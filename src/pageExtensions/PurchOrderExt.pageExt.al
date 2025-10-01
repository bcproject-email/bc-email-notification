pageextension 50112 "Purch. Order Ext" extends "Purchase Order"
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("Send E-mail To"; Rec."Send E-mail To")
            {
                ApplicationArea = All;
                InstructionalText = 'Enter multiple email addresses separated by semicolons.';
                Caption = 'Send E-mail To';
                ToolTip = 'Specifies the email address to which notifications for this purchase order will be sent. Multiple addresses can be separated by semicolons.';
            }
        }
    }
}