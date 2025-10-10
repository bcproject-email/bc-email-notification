codeunit 80101 EmailTransferSubscribers
{

    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", OnBeforeWhseReceiptHeaderInsert, '', false, false)]
    local procedure OnBeforeWhseReceiptHeaderInsert(var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var WarehouseRequest: Record "Warehouse Request")
    var
        Purchaseheader: Record "Purchase Header";
    begin
        if WarehouseRequest."Source Type" <> Database::"Purchase Line" then
            exit;

        Purchaseheader.Get(Purchaseheader."Document Type"::Order, WarehouseRequest."Source No.");
        WarehouseReceiptHeader."Send E-mail To" := Purchaseheader."Send E-mail To";
    end;
}