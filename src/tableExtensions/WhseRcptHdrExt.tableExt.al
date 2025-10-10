tableextension 80102 "Whse Rcpt Hdr Ext" extends "Warehouse Receipt Header"
{
    fields
    {
        field(50119; "Send E-mail To"; Text[2048])
        {
            Caption = 'Send E-mail To';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}