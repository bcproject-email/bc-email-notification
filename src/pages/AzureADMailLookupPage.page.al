page 80100 "Azure AD Mail Lookup Page"
{
    PageType = List;
    SourceTable = "Temp Email Results";
    Editable = false;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Display Name"; Rec."Display Name") { ApplicationArea = All; }
                field("Email"; Rec."Email") { ApplicationArea = All; }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = Action::LookupOK then
            CurrPage.SetSelectionFilter(Rec);
    end;
}