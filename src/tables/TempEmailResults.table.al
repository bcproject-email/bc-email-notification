table 80100 "Temp Email Results"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Email"; Text[100]) { }
        field(2; "Display Name"; Text[100]) { }
    }

    keys
    {
        key(Pk; Email)
        {
        }
    }
}