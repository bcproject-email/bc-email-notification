codeunit 50146 "PO Email State"
{
    SingleInstance = true;

    var
        ShippedSent: Dictionary of [Code[20], Boolean];
        ArrivedSent: Dictionary of [Code[20], Boolean];
        uniquePos: List of [Code[20]];
        PostedeReceiptHeaderNo: Code[20];

    procedure ShouldSendShipped(ReceiptNo: Code[20]): Boolean
    begin
        exit(not ShippedSent.ContainsKey(ReceiptNo));
    end;

    procedure MarkShippedSent(ReceiptNo: Code[20])
    begin
        ShippedSent.Set(ReceiptNo, true);
    end;

    procedure ShouldSendArrived(PostedReceiptNo: Code[20]): Boolean
    begin
        exit(not ArrivedSent.ContainsKey(PostedReceiptNo));
    end;

    procedure MarkArrivedSent(PostedReceiptNo: Code[20])
    begin
        ArrivedSent.Set(PostedReceiptNo, true);
    end;

    procedure AddUniquePOs(PoNo: Code[20])
    begin
        if (PONo <> '') and not UniquePOs.Contains(PONo) then
            UniquePOs.Add(PONo);
    end;

    procedure SetPostedReceiptHeaderNo(PostedReceiptNo: Code[20])
    begin
        // Just a placeholder for now, in case we need it later
        PostedeReceiptHeaderNo := PostedReceiptNo;
    end;

    procedure GetPostedReceiptHeaderNo(): Code[20]
    begin
        exit(PostedeReceiptHeaderNo);
    end;

    procedure GetUniquePos(var Pos: List of [Code[20]])
    begin
        Pos := UniquePos;
    end;

    procedure ClearUniquePos()
    begin
        CLEAR(UniquePos);
    end;

    procedure ResetAll()
    begin
        CLEAR(ShippedSent);
        CLEAR(ArrivedSent);
    end;
}