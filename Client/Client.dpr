program Client;

uses
  Vcl.Forms,
  ClientForm.View in 'ClientForm.View.pas' {ClientForm1},
  ClientUnit in 'ClientUnit.pas',
  CSUtils in '..\Common\CSUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TClientForm1, ClientForm1);
  Application.Run;
end.
