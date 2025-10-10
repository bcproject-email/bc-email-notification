pageextension 80102 "Whse Rcpt Ext" extends "Warehouse Receipt"
{
    layout
    {
        addafter("No.")
        {
            field("Send E-mail To"; Rec."Send E-mail To")
            {
                ApplicationArea = All;
                Caption = 'Send E-mail To';
                ToolTip = 'Specifies the email address to which notifications for this warehouse receipt will be sent. Multiple addresses can be separated by semicolons.';
            }
        }
    }
}