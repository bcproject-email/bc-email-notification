codeunit 50148 "PO Email Dispatcher"
{
    TableNo = "Purchase Header";

    trigger OnRun()
    var
        Helper: Codeunit "PO Email Helper";
        PurchaseHeader: Record "Purchase Header";
    begin
        // Safety: re-get the record we received, just in case
        if (Rec."Document Type" <> Rec."Document Type"::Order) or (Rec."No." = '') then
            exit;

        PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, Rec."No.");
        Helper.Notify_POCreated_OnRelease(PurchaseHeader);
    end;
}