tableextension 80101 PurchaseHeaderExt extends "Purchase Header"
{
    fields
    {
        field(50119; "Send E-mail To"; Text[2048])
        {
            Caption = 'Send E-mail To';
            DataClassification = CustomerContent;
        }
    }
}