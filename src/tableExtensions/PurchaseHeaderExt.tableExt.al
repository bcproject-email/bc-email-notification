tableextension 50119 PurchaseHeaderExt extends "Purchase Header"
{
    fields
    {
        field(50119; "Send E-mail To"; Text[250])
        {
            Caption = 'Send E-mail To';
            DataClassification = CustomerContent;
        }
    }
}