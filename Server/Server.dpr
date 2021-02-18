program Server;

uses
  Vcl.Forms,
  ServerForm.View in 'ServerForm.View.pas' {ServerForm1},
  ServerUnit in 'ServerUnit.pas',
  CSUtils in '..\Common\CSUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerForm1, ServerForm1);
  Application.Run;
end.
