program DDuce.Tests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$I Test.DDuce.inc}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnit,
  {$ELSE}
  GUITestRunner,
  {$ENDIF }
  Test.DDuce.DynamicRecord in 'Test.DDuce.DynamicRecord.pas',
  Test.Data in 'Test.Data.pas',
  Test.DDuce.DynamicRecord.Generic in 'Test.DDuce.DynamicRecord.Generic.pas',
  Test.Registration in 'Test.Registration.pas',
  Test.DDuce.Reflect in 'Test.DDuce.Reflect.pas',
  Test.Utils in 'Test.Utils.pas',
  DDuce.DynamicRecord in '..\Source\DDuce.DynamicRecord.pas',
  DDuce.Logger in '..\Source\DDuce.Logger.pas',
  DDuce.RandomData in '..\Source\DDuce.RandomData.pas',
  DDuce.Reflect in '..\Source\DDuce.Reflect.pas',
  DDuce.ScopedReference in '..\Source\DDuce.ScopedReference.pas';

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  RegisterTests;
  RunRegisteredTests;
end.

