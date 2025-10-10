codeunit 80100 AzureAdMailLookup
{
    procedure SearchEmails(SearchText: Text; var TempResults: Record "Temp Email Results")
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        JsonResponse: JsonObject;
        ValueArray: JsonArray;
        UserToken, ValueArrayToken, DisplayNameToken, MailToken : JsonToken;
        UserObj: JsonObject;
        Token: Text;
        Url, ContentText : Text;
        Mail, DisplayName : Text;
        i: Integer;
    begin
        // Get Azure AD token
        Token := GetAccessToken();

        // Build Graph API URL with filter
        Url := 'https://graph.microsoft.com/v1.0/users?$select=displayName,mail,userPrincipalName,otherMails&$top=500';

        Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + Token);

        // Call Graph API
        if not Client.Get(Url, Response) then
            Error('Failed to call Graph API');

        Response.Content.ReadAs(ContentText);

        if not JsonResponse.ReadFrom(ContentText) then
            Error('Invalid JSON response from Graph API');

        // Parse the 'value' array returned by Graph
        JsonResponse.Get('value', ValueArrayToken);
        ValueArray := ValueArrayToken.AsArray();
        for i := 0 to ValueArray.Count() - 1 do begin

            // Get the JsonToken at index i
            ValueArray.Get(i, UserToken);

            // Convert JsonToken to JsonObject
            UserObj := UserToken.AsObject();

            // Extract displayName
            UserObj.Get('displayName', DisplayNameToken);
            DisplayNameToken.WriteTo(DisplayName);

            // Extract mail
            UserObj.Get('mail', MailToken);
            if not MailToken.AsValue().IsNull() then begin
                MailToken.WriteTo(Mail);
                // Insert into temp table
                TempResults.Init();
                TempResults."Email" := CopyStr(Mail, 2, StrLen(Mail) - 2);
                TempResults."Display Name" := CopyStr(DisplayName, 2, StrLen(DisplayName) - 2);
                TempResults.Insert();
            end;
        end;
    end;
}