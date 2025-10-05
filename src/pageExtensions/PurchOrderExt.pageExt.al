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

    actions
    {
        addlast(Processing)
        {
            action(SendPOCreatedEmail)
            {
                ApplicationArea = All;
                Caption = 'Send Created Email';
                Image = Email;
                ToolTip = 'Send the PO Created email (runs outside the Release transaction).';

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                    Helper: Codeunit "PO Email Helper";
                begin
                    PurchaseHeader.Get(Rec."Document Type", Rec."No.");
                    Helper.Notify_POCreated_OnRelease(PurchaseHeader);
                    Message('Created email sent for PO %1.', PurchaseHeader."No.");
                end;
            }
        }
    }
}