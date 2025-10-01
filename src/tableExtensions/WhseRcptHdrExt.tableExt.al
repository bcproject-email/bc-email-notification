tableextension 50124 "Whse Rcpt Hdr Ext" extends "Warehouse Receipt Header"
{
    fields
    {
        field(50119; "Send E-mail To"; Text[250])
        {
            Caption = 'Send E-mail To';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}