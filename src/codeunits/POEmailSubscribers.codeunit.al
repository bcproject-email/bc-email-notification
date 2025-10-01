codeunit 50143 "PO Email Subscribers"
{

    var
        EmailState: Codeunit "PO Email State";
        Helper: Codeunit "PO Email Helper";

    // 1) PO Released -> "PO Created"
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure OnAfterReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then
            exit;

        Helper.Notify_POCreated_OnRelease(PurchaseHeader);
    end;

    // 2) WR CREATED -> "Shipped" (fires when WR header is created from PO)
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Source Doc. Inbound", 'OnAfterCreateWhseReceiptHeaderFromWhseRequest', '', false, false)]
    local procedure OnAfterCreateWhseReceiptHeaderFromWhseRequest(var WhseReceiptHeader: Record "Warehouse Receipt Header")
    var
        WhseRcptLine: Record "Warehouse Receipt Line";
        PurchHeader: Record "Purchase Header";
        UniquePOs: List of [Code[20]];
        PONo: Code[20];
    begin
        WhseRcptLine.SetRange("No.", WhseReceiptHeader."No.");
        if WhseRcptLine.FindSet() then
            repeat
                if WhseRcptLine."Source Type" = Database::"Purchase Line" then begin
                    PONo := WhseRcptLine."Source No.";
                    if (PONo <> '') and not UniquePOs.Contains(PONo) then
                        UniquePOs.Add(PONo);
                end;
            until WhseRcptLine.Next() = 0;

        foreach PONo in UniquePOs do
            if PurchHeader.Get(PurchHeader."Document Type"::Order, PONo) then
                Helper.Notify_Shipped_OnWhseReceiptCreated(WhseReceiptHeader, PurchHeader);
    end;

    // 3) WR POSTED -> "Arrived"
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnAfterPostedWhseRcptLineInsert, '', false, false)]
    local procedure OnAfterPostedWhseRcptLineInsert(var PostedWhseReceiptLine: Record "Posted Whse. Receipt Line"; WarehouseReceiptLine: Record "Warehouse Receipt Line")
    var
        PONo: Code[20];
    begin
        if PostedWhseReceiptLine."Source Type" <> Database::"Purchase Line" then
            exit;

        PONo := PostedWhseReceiptLine."Source No.";
        EmailState.AddUniquePOs(PONo);
        EmailState.SetPostedReceiptHeaderNo(PostedWhseReceiptLine."No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnAfterCode, '', false, false)]
    local procedure OnAfterCode(CounterSourceDocOK: Integer; CounterSourceDocTotal: Integer)
    var
        PostedHdr: Record "Posted Whse. Receipt Header";
        PurchHeader: Record "Purchase Header";
        PONo: Code[20];
        UniquePos: List of [Code[20]];
    begin
        if CounterSourceDocOK <> CounterSourceDocTotal then
            exit;

        if not PostedHdr.Get(EmailState.GetPostedReceiptHeaderNo()) then
            exit;

        EmailState.GetUniquePos(UniquePos);
        foreach PONo in UniquePOs do
            if PurchHeader.Get(PurchHeader."Document Type"::Order, PONo) then
                Helper.Notify_Arrived_OnWhseReceiptPosted(PostedHdr, PurchHeader);

        EmailState.ClearUniquePos();
    end;
}