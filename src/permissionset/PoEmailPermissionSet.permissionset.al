permissionset 80100 PoEmailPermissionSet
{
    Permissions = tabledata "Temp Email Results" = RIMD,
        table "Temp Email Results" = X,
        codeunit AzureAdMailLookup = X,
        codeunit EmailTransferSubscribers = X,
        codeunit "PO Email Dispatcher" = X,
        codeunit "PO Email Helper" = X,
        codeunit "PO Email Subscribers" = X,
        page "Azure AD Mail Lookup Page" = X;
}