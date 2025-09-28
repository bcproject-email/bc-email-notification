pageextension 50147 "PO Send Created Ext" extends "Purchase Order"
{
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