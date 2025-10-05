codeunit 50146 "PO Email State"
{
    SingleInstance = true;

    var
        ShippedSent: Dictionary of [Code[20], Boolean];
        ArrivedSent: Dictionary of [Code[20], Boolean];
        uniquePos: List of [Code[20]];
        PostedeReceiptHeaderNo: Code[20];

    [Obsolete('No longer used, will be removed in future versions.')]
    procedure ShouldSendShipped(ReceiptNo: Code[20]): Boolean
    begin
        exit(not ShippedSent.ContainsKey(ReceiptNo));
    end;

    [Obsolete('No longer used, will be removed in future versions.')]
    procedure MarkShippedSent(ReceiptNo: Code[20])
    begin
        ShippedSent.Set(ReceiptNo, true);
    end;

    [Obsolete('No longer used, will be removed in future versions.')]
    procedure ShouldSendArrived(PostedReceiptNo: Code[20]): Boolean
    begin
        exit(not ArrivedSent.ContainsKey(PostedReceiptNo));
    end;

    [Obsolete('No longer used, will be removed in future versions.')]
    procedure MarkArrivedSent(PostedReceiptNo: Code[20])
    begin
        ArrivedSent.Set(PostedReceiptNo, true);
    end;

    [Obsolete('No longer used, will be removed in future versions.')]
    procedure AddUniquePOs(PoNo: Code[20])
    begin
        if (PONo <> '') and not UniquePOs.Contains(PONo) then
            UniquePOs.Add(PONo);
    end;

    [Obsolete('No longer used, will be removed in future versions.')]
    procedure SetPostedReceiptHeaderNo(PostedReceiptNo: Code[20])
    begin
        // Just a placeholder for now, in case we need it later
        PostedeReceiptHeaderNo := PostedReceiptNo;
    end;

    [Obsolete('No longer used, will be removed in future versions.')]
    procedure GetPostedReceiptHeaderNo(): Code[20]
    begin
        exit(PostedeReceiptHeaderNo);
    end;

    [Obsolete('No longer used, will be removed in future versions.')]
    procedure GetUniquePos(var Pos: List of [Code[20]])
    begin
        Pos := UniquePos;
    end;

    [Obsolete('No longer used, will be removed in future versions.')]
    procedure ClearUniquePos()
    begin
        CLEAR(UniquePos);
    end;

    [Obsolete('No longer used, will be removed in future versions.')]
    procedure ResetAll()
    begin
        CLEAR(ShippedSent);
        CLEAR(ArrivedSent);
    end;
}