tableextension 50129 "Posted Whse Rcpt Hdr Ext" extends "Posted Whse. Receipt Header"
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