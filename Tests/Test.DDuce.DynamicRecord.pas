{
  Copyright (C) 2013-2015 Tim Sinaeve tim.sinaeve@gmail.com

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
}

unit Test.DDuce.DynamicRecord;

{$I Test.DDuce.inc}

{ Tests all members of the non-generic version of TRecord. }

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.Variants,
  Winapi.Windows, Winapi.Messages,
  Vcl.ActnList, Vcl.Forms, Vcl.Buttons, Vcl.Graphics,
  Data.DB,
  Datasnap.DBClient,

  DDuce.DynamicRecord, DDuce.RandomData,

  {$IFDEF SPRING}
  Spring,
  {$ENDIF}

  TestFramework, // DUnit

  Test.Data;

type
  TestTRecord = class(TTestCase)
  private
    FRecord        : TRecord;
    FDynamicRecord : IDynamicRecord;

    function RetrieveRecord(
      const AString : string;
       var  ARecord : TRecord
    ): Boolean;
    function RetrieveRecordFunction: TRecord;

    procedure PassingArgumentByValueParam(ARecord: TRecord);
    procedure PassingArgumentByConstParam(const ARecord: TRecord);
    procedure PassingArgumentByVarParam(var ARecord: TRecord);
    procedure PassingArgumentByInterfaceParam(ARecord: IDynamicRecord);

  public
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure Test_passing_TRecord_argument_as_const_parameter;
    procedure Test_passing_TRecord_argument_as_var_parameter;
    procedure Test_passing_TRecord_argument_as_value_parameter;
    procedure Test_passing_TRecord_argument_as_IDynamicRecord_parameter;
    procedure Test_passing_IDynamicRecord_argument_as_value_parameter;
    procedure Test_passing_IDynamicRecord_argument_as_const_parameter;
    procedure Test_passing_IDynamicRecord_argument_as_IDynamicRecord_parameter;

    procedure Test_Assign_method_for_IDynamicRecord_argument;
    procedure Test_Assign_method_for_TRecord_argument;
    procedure Test_Assign_method_for_generic_IDynamicRecord_argument;
    procedure Test_Assign_method_for_generic_TRecord_argument;

    procedure Test_assignment_operator_for_TRecord_to_TRecord;
    procedure Test_assignment_operator_for_TRecord_to_IDynamicRecord;
    procedure Test_assignment_operator_for_IDynamicRecord_to_TRecord;

    procedure Test_faulty_condition;

    procedure Test_ContainsField_method;
    procedure Test_DeleteField_method;

    procedure Test_IsEmpty_method;
    procedure Test_IsBlank_method;

    // test methods with automatic conversion to destination type
    procedure Test_ToFloat_method;
    procedure Test_ToInteger_method;
    procedure Test_ToString_method;
    procedure Test_ToBoolean_method;

    procedure Test_FromDataSet_method;
    procedure Test_FromStrings_method;
    procedure Test_From_method;

    procedure Test_AsDelimitedText_method;
    procedure Test_AsVarArray_method;
    procedure Test_AsCommaText_method;
    procedure Test_ToStrings_method;

    procedure Test_AssignProperty_method;

    procedure Test_AssignTo_method_for_Object;

    procedure TestRetrieveRecord;
    procedure TestRetrieveRecordFunction;

  end;

implementation

uses
  System.Math, System.Types, System.Rtti,
  Vcl.Dialogs,

  DDuce.Logger,

  Test.Utils;

const
  TEST_INTEGER            = 'TestInteger';
  TEST_DOUBLE             = 'TestDouble';
  TEST_BOOLEAN            = 'TestBoolean';
  TEST_STRING             = 'TestString';
  TEST_STRING_INTEGER     = 'TestStringInteger';
  TEST_STRING_DOUBLE      = 'TestStringDouble';
  TEST_TVALUE             = 'TestTValue';
  TEST_CHAR               = 'TestChar';
  TEST_VARIANT            = 'TestVariant';
  TEST_NON_EXISTENT_VALUE = 'TestNonExistentValue';

{$REGION 'SetUp and TearDown methods'}
procedure TestTRecord.SetUp;
begin
  FRecord[TEST_INTEGER]        := 5;
  FRecord[TEST_STRING]         := 'Test';
  FRecord[TEST_STRING_INTEGER] := '5';
  FRecord[TEST_STRING_DOUBLE]  := '3,14';
  FRecord[TEST_BOOLEAN]        := True;
  FRecord[TEST_DOUBLE]         := 3.14;
  FRecord[TEST_CHAR]           := 'C';

  FDynamicRecord := TRecord.CreateDynamicRecord;
  FDynamicRecord[TEST_INTEGER]        := 5;
  FDynamicRecord[TEST_STRING]         := 'Test';
  FDynamicRecord[TEST_STRING_INTEGER] := '5';
  FDynamicRecord[TEST_STRING_DOUBLE]  := '3,14';
  FDynamicRecord[TEST_BOOLEAN]        := True;
  FDynamicRecord[TEST_DOUBLE]         := 3.14;
  FDynamicRecord[TEST_CHAR]           := 'C';
end;

procedure TestTRecord.TearDown;
begin
  FRecord.Clear;
  FDynamicRecord := nil;
end;
{$ENDREGION}

{$REGION 'private methods'}
// helper methods used in tests

procedure TestTRecord.PassingArgumentByConstParam(const ARecord: TRecord);
var
  S : string;
  F : IDynamicField;
begin
  ARecord.Data.NewValue := 'Test';
  ARecord['NewValue2'] := 'Test';
  for F in ARecord do
  begin
    Status(F.ToString);
  end;
  S := Format('PassingRecordThroughConstParam: '#13#10'%s', [ARecord.ToString]);
end;

procedure TestTRecord.PassingArgumentByInterfaceParam(
  ARecord: IDynamicRecord);
var
  S : string;
begin
  ARecord.Data.NewValue := 'Test';
  ARecord['NewValue2'] := 'Test';
  S := Format('PassingRecordThroughInterfaceParam: '#13#10'%s', [ARecord.ToString]);
end;

procedure TestTRecord.PassingArgumentByValueParam(ARecord: TRecord);
var
  F : IDynamicField;
begin
  for F in ARecord do
  begin
    Status(F.ToString);
  end;
  ARecord.Data.NewValue := 'Test';
  ARecord['NewValue2'] := 'Test';
end;

{ For var parameters the type of the passed value does have to match with the
  type of the parameter. So
              PassingArgumentByVarParam(FDynamicRecord);
  will not compile.
}
procedure TestTRecord.PassingArgumentByVarParam(var ARecord: TRecord);
var
  S : string;
begin
  ARecord.Data.NewValue := 'Test';
  ARecord['NewValue2'] := 'Test';
  S := Format('PassingRecordThroughVarParam: '#13#10'%s', [ARecord.ToString]);
  Status(S);
end;

function TestTRecord.RetrieveRecordFunction: TRecord;
begin
  Result['Test'] := 'test';
end;

function TestTRecord.RetrieveRecord(const AString: string;
  var ARecord: TRecord): Boolean;
var
  DS: TDataSet;
begin
  DS := TTestUtils.CreateDataSet(10);
  try
    Result := True;
    ARecord.FromDataSet(DS);
    ARecord['Test'] := AString;
    ARecord['Count'] := DS.RecordCount;
  finally
    DS.Free;
  end;
end;
{$ENDREGION}

{$REGION 'Test methods that convert all content to another format'}
procedure TestTRecord.Test_AsCommaText_method;
begin
  CheckEqualsString(
    '5,Test,5,3,14,True,3,14,C',
    FRecord.AsCommaText
  );
end;

procedure TestTRecord.Test_AsDelimitedText_method;
begin
  CheckEqualsString('5,Test,5,3,14,True,3,14,C', FRecord.AsDelimitedText(','));
  CheckEqualsString('5', FRecord.AsDelimitedText(TEST_INTEGER, ','));
end;

procedure TestTRecord.Test_AsVarArray_method;
var
  VA : Variant;
  I  : Integer;
  N  : Integer;
  V  : Variant;
  S  : string;
begin
  VA := FRecord.AsVarArray;
  N := VarArrayDimCount(VA);
  for I := VarArrayLowBound(VA, N) to VarArrayHighBound(VA, N) do
  begin
    V := VarArrayGet(VA, [I]);
    S := Format('[%d] = %s', [I, VarToStrDef(V, '')]);
    Status(S);
    CheckEqualsString(VarToStrDef(V, ''), FRecord.Items[I].Value.ToString);
  end;
end;

procedure TestTRecord.Test_ToStrings_method;
var
  SL : TStrings;
  F  : IDynamicField;
begin
  SL := TStringList.Create;
  try
    FRecord.ToStrings(SL);
    for F in FRecord do
    begin
      CheckEqualsString(F.Value.ToString, SL.Values[F.Name]);
    end;
  finally
    SL.Free;
  end;
end;
{$ENDREGION}

{$REGION 'Test methods that load all content from another format'}
procedure TestTRecord.Test_FromDataSet_method;
var
  DS : TDataSet;
  R  : TRecord;
  F  : IDynamicField;
begin
  DS := TTestUtils.CreateDataSet(100);
  try
    DS.First;
    while not DS.Eof do
    begin
      R.FromDataSet(DS);
      {$IFDEF SPRING}
      for F in R do
      begin
        CheckTrue(F.Value.Equals(TValue.FromVariant(DS[F.Name])));
      end;
      {$ENDIF}
      Status(R.ToString);
      DS.Next;
    end;
  finally
    FreeAndNil(DS);
  end;
end;

procedure TestTRecord.Test_FromStrings_method;
var
  SL : TStrings;
  R  : TRecord;
begin
  SL := TStringList.Create;
  try
    SL.Values['S'] := 'test';
    SL.Values['I'] := '5';
    R.FromStrings(SL);
    CheckTrue(R.ToInteger('I') = 5, 'I');
    CheckTrue(R.ToString('S') = 'test', 'S');
  finally
    SL.Free;
  end;
end;
{$ENDREGION}

{$REGION 'Test Assign methods'}
procedure TestTRecord.Test_Assign_method_for_IDynamicRecord_argument;
var
  R : TRecord;
  F : IDynamicField;
begin
  R.Assign(FDynamicRecord);
  {$IFDEF SPRING}
  for F in R do
  begin
    CheckTrue(FDynamicRecord[F.Name].Equals(F.Value));
  end;
  {$ENDIF}
  CheckEquals(FDynamicRecord.Data.TestBoolean, R[TEST_BOOLEAN].AsBoolean, TEST_BOOLEAN);
  CheckEquals(FDynamicRecord.Data.TestInteger, R[TEST_INTEGER].AsInteger, TEST_INTEGER);
  CheckEquals(FDynamicRecord.Data.TestString, R[TEST_STRING].AsString, TEST_STRING);
end;

procedure TestTRecord.Test_Assign_method_for_TRecord_argument;
var
  R : TRecord;
  F : IDynamicField;
begin
  R.Assign(FRecord);
  {$IFDEF SPRING}
  for F in R do
  begin
    CheckTrue(FRecord[F.Name].Equals(F.Value));
  end;
  {$ENDIF}
  CheckEquals(FRecord.Data.TestBoolean, R[TEST_BOOLEAN].AsBoolean, TEST_BOOLEAN);
  CheckEquals(FRecord.Data.TestInteger, R[TEST_INTEGER].AsInteger, TEST_INTEGER);
  CheckEquals(FRecord.Data.TestString, R[TEST_STRING].AsString, TEST_STRING);
end;
{$ENDREGION}

{$REGION 'Tests of field manipulation methods'}
procedure TestTRecord.Test_ContainsField_method;
begin
  // Test ContainsField method
  CheckTrue(FRecord.ContainsField(TEST_INTEGER), TEST_INTEGER);
  CheckTrue(FRecord.ContainsField(UpperCase(TEST_INTEGER)), TEST_INTEGER);
  CheckTrue(FRecord.ContainsField(TEST_STRING), TEST_STRING);
  CheckTrue(FRecord.ContainsField(TEST_BOOLEAN), TEST_BOOLEAN);
  CheckFalse(FRecord.ContainsField(TEST_NON_EXISTENT_VALUE), TEST_NON_EXISTENT_VALUE);
  CheckTrue(FRecord.ContainsField(TEST_DOUBLE), TEST_DOUBLE);
end;

procedure TestTRecord.Test_DeleteField_method;
begin
  // Test DeleteField
  CheckTrue(FRecord.DeleteField(TEST_INTEGER), TEST_INTEGER);
  // Check if it is really gone
  CheckFalse(FRecord.ContainsField(TEST_INTEGER), TEST_INTEGER);
end;
{$ENDREGION}

{$REGION 'Tests for methods that check the content'}
procedure TestTRecord.Test_IsBlank_method;
var
  R : TRecord;
  S : string;
begin
  S := TEST_NON_EXISTENT_VALUE;
  CheckTrue(R.IsBlank(S), S);

  S := 'TestEmptyString';
  R[S] := '';
  CheckTrue(R.IsBlank(S), S);

  S := 'TestEmptyValue';
  R[S] := TValue.Empty;
  CheckTrue(R.IsBlank(S), S);

  S := TEST_STRING;
  R[S] := 'Test';
  CheckFalse(R.IsBlank(S), S);

  S := TEST_INTEGER;
  R[S] := 0;
  CheckFalse(R.IsBlank(S), S);

  S := TEST_DOUBLE;
  R[S] := 3.14;
  CheckFalse(R.IsBlank(S), S);
  R[S] := NaN;
  CheckFalse(R.IsBlank(S), S);
  R[S] := Infinity;
  CheckFalse(R.IsBlank(S), S);
  R[S] := NegInfinity;
  CheckFalse(R.IsBlank(S), S);
  R[S] := 0.0;
  CheckFalse(R.IsBlank(S), S);

  S := TEST_BOOLEAN;
  R[S] := False;
  CheckFalse(R.IsBlank(S), S);

  S := TEST_VARIANT;
  R[S] := TValue.FromVariant(Null);
  CheckTrue(R.IsBlank(S), 'Null');
  R[S] := TValue.FromVariant(Unassigned);
  CheckTrue(R.IsBlank(S), 'Unassigned');
  // EmptyParam does not translate to TValue.Empty.
  R[S] := TValue.FromVariant(EmptyParam);
  CheckFalse(R.IsBlank(S), 'EmptyParam');

  R[S] := TValue.FromVariant('');
  CheckTrue(R.IsBlank(S), 'Empty string');
end;

procedure TestTRecord.Test_IsEmpty_method;
var
  R : TRecord;
begin
  CheckTrue(R.IsEmpty);

  R['S'] := 'test';
  CheckFalse(R.IsEmpty);

  R['T'] := 'test';
  R.Clear;
  CheckTrue(R.IsEmpty);

  R['T'] := 'test';
  R.DeleteField('T');
  CheckTrue(R.IsEmpty);
end;
{$ENDREGION}

{$REGION 'Passing TRecord instances as an argument'}
{ When passing as a const parameter no copy is made of the argument. However,
  inspite of being a const parameter it is possible to change its value in
  the method call. This behaviour is normal as explained here:
  http://stackoverflow.com/questions/7413899/record-methods-and-const-parameters-in-delphi
  Using const in this case is equivalent as passing by reference (or var
  parameter).
}
procedure TestTRecord.Test_passing_TRecord_argument_as_const_parameter;
var
  R : TRecord;
begin
  R.Data.B := False;
  R.Data.I := 10;
  R.Data.S := 'string';
  R.Data.F := 3.14;
  PassingArgumentByConstParam(R);
  CheckTrue(R.Data.NewValue = 'Test');
  CheckTrue(R.Data.NewValue2 = 'Test');
end;

{ When passing a TRecord value through a IDynamicRecord parameter, an implicit
  copy is created by the overloaded assignment operator of TRecord. }
procedure TestTRecord.Test_passing_TRecord_argument_as_IDynamicRecord_parameter;
var
  R : TRecord;
begin
  R.Data.B := False;
  R.Data.I := 10;
  R.Data.S := 'string';
  R.Data.F := 3.14;
  PassingArgumentByInterfaceParam(R);
  CheckFalse(R.Data.NewValue = 'Test');
  CheckFalse(R.Data.NewValue2 = 'Test');
end;

{ When passing a TRecord by value, an implicit copy is created. }
procedure TestTRecord.Test_passing_TRecord_argument_as_value_parameter;
var
  R : TRecord;
begin
  R.Data.B := False;
  R.Data.I := 10;
  R.Data.S := 'string';
  R.Data.F := 3.14;
  PassingArgumentByValueParam(R);
  CheckFalse(R.Data.NewValue = 'Test');
  CheckFalse(R.Data.NewValue2 = 'Test');
end;

{ When passing a TRecord by reference (var parameter), no copy is created. }
procedure TestTRecord.Test_passing_TRecord_argument_as_var_parameter;
begin
  PassingArgumentByVarParam(FRecord);
  CheckTrue(FRecord.Data.NewValue = 'Test');
  CheckTrue(FRecord.Data.NewValue2 = 'Test');
end;

{ As the IDynamicRecord argument is implicitly casted to TRecord, a copy of
  its content is made. }
procedure TestTRecord.Test_passing_IDynamicRecord_argument_as_value_parameter;
begin
  PassingArgumentByValueParam(FDynamicRecord);
  CheckFalse(FDynamicRecord.Data.NewValue = 'Test');
  CheckFalse(FDynamicRecord.Data.NewValue2 = 'Test');
end;

{ As the IDynamicRecord argument is implicitly casted to TRecord, a copy of
  its content is made. }
procedure TestTRecord.Test_passing_IDynamicRecord_argument_as_const_parameter;
begin
  PassingArgumentByConstParam(FDynamicRecord);
  CheckFalse(FDynamicRecord.Data.NewValue = 'Test');
  CheckFalse(FDynamicRecord.Data.NewValue2 = 'Test');
  Status(FDynamicRecord.ToString);
end;

{ As we pass the reference, no copy is made. }
procedure TestTRecord.Test_passing_IDynamicRecord_argument_as_IDynamicRecord_parameter;
begin
  PassingArgumentByInterfaceParam(FDynamicRecord);
  CheckTrue(FDynamicRecord.Data.NewValue = 'Test');
  CheckTrue(FDynamicRecord.Data.NewValue2 = 'Test');
  Status(FDynamicRecord.ToString);
end;
{$ENDREGION}

{$REGION 'Tests for methods that convert the TValue to the destination type'}
procedure TestTRecord.Test_ToBoolean_method;
begin
  CheckTrue(FRecord.ToBoolean(TEST_STRING, True), TEST_STRING);
  CheckTrue(FRecord.ToBoolean(TEST_STRING_INTEGER, True), TEST_STRING_INTEGER);
  CheckTrue(FRecord.ToBoolean(TEST_STRING_DOUBLE, True), TEST_STRING_DOUBLE);
  CheckTrue(FRecord.ToBoolean(TEST_DOUBLE, True), TEST_DOUBLE);
  CheckTrue(FRecord.ToBoolean(TEST_BOOLEAN, True), TEST_BOOLEAN);
  CheckTrue(FRecord.ToBoolean(TEST_INTEGER, True), TEST_INTEGER);
end;

procedure TestTRecord.Test_ToFloat_method;
begin
  CheckEquals(5, FRecord.ToFloat(TEST_INTEGER), TEST_INTEGER);
  CheckTrue(IsZero(FRecord.ToFloat(TEST_STRING)), TEST_STRING);
  CheckTrue(IsZero(FRecord.ToFloat(TEST_BOOLEAN)), TEST_BOOLEAN);
  CheckEquals(3.14, FRecord.ToFloat(TEST_DOUBLE), 0.001);
end;

procedure TestTRecord.Test_ToInteger_method;
begin
  CheckEquals(1, FRecord.ToInteger(TEST_BOOLEAN), TEST_BOOLEAN);
  CheckEquals(5, FRecord.ToInteger(TEST_INTEGER), TEST_INTEGER);
  CheckEquals(0, FRecord.ToInteger(TEST_STRING), TEST_STRING);
  CheckEquals(5, FRecord.ToInteger(TEST_STRING_INTEGER), TEST_STRING_INTEGER);
  CheckEquals(0, FRecord.ToInteger(TEST_STRING_DOUBLE), TEST_STRING_DOUBLE);

  // float values are not rounded or trunked when converting. Conversion fails.
  CheckEquals(0, FRecord.ToInteger(TEST_DOUBLE), TEST_DOUBLE);
end;

procedure TestTRecord.Test_ToString_method;
begin
  CheckEquals('True', FRecord.ToString(TEST_BOOLEAN), TEST_BOOLEAN);
  CheckEquals('5', FRecord.ToString(TEST_INTEGER), TEST_INTEGER);
  CheckEquals('Test', FRecord.ToString(TEST_STRING), TEST_STRING);
  CheckEquals('5', FRecord.ToString(TEST_STRING_INTEGER), TEST_STRING_INTEGER);
  CheckEquals('3,14', FRecord.ToString(TEST_STRING_DOUBLE), TEST_STRING_DOUBLE);
  CheckEquals('3,14', FRecord.ToString(TEST_DOUBLE), TEST_DOUBLE);
end;

{$REGION 'Operator overload tests'}
{ Assigning a TRecord to a TRecord results in creating a copy. }
procedure TestTRecord.Test_assignment_operator_for_TRecord_to_TRecord;
var
  R: TRecord;
begin
  R := FRecord;
  FRecord[TEST_INTEGER] := 6;
  CheckEquals(5, R[TEST_INTEGER].AsInteger, TEST_INTEGER);
end;

{ Assigning a TRecord to a IDynamicRecord results in creating a copy of the
  content. }
procedure TestTRecord.Test_assignment_operator_for_TRecord_to_IDynamicRecord;
var
  DR : IDynamicRecord;
begin
  // if DR is nil like here, a new instance with a copy of the data is
  // automatically created by the overloaded assignment operator of TRecord.
  DR := FRecord;
  FRecord[TEST_STRING] := 'another value';
  CheckEquals('Test', DR[TEST_STRING].AsString); // a copy has been made
end;

{ Assigning an IDynamicRecord to a TRecord results in creating a copy. }
procedure TestTRecord.Test_assignment_operator_for_IDynamicRecord_to_TRecord;
var
  R: TRecord;
begin
  R := FDynamicRecord;
  R[TEST_INTEGER] := 6;
  CheckEquals(5, FDynamicRecord[TEST_INTEGER].AsInteger, TEST_INTEGER);
end;
{$ENDREGION}

procedure TestTRecord.Test_AssignProperty_method;
var
  O  : TTestClass;
  R  : TRecord;
begin
  O := TTestClass.Create;
  try
    O.TestBoolean := True;
    O.TestString  := 'test';
    O.TestInteger := 5;
    O.TestDouble  := 3.14;
    // fill the TRecord instance with property name-value pairs.
    R.AssignProperty(O, TEST_BOOLEAN);
    R.AssignProperty(O, TEST_STRING);
    R.AssignProperty(O, TEST_INTEGER);
    R.AssignProperty(O, TEST_DOUBLE);
    CheckEquals(O.TestBoolean, R[TEST_BOOLEAN].AsBoolean, TEST_BOOLEAN);
    CheckEquals(O.TestInteger, R[TEST_INTEGER].AsInteger, TEST_INTEGER);
    CheckEquals(O.TestString, R[TEST_STRING].AsString, TEST_STRING);
    CheckEquals(O.TestDouble, R[TEST_DOUBLE].AsExtended, TEST_DOUBLE);
  finally
    O.Free;
  end;
end;

procedure TestTRecord.TestRetrieveRecord;
var
  R : TRecord;
  I : Integer;
begin
  for I := 0 to 100 do
  begin
    RetrieveRecord(RandomData.Name, R);
    Status(R['Test'].AsString);
  end;
  CheckTrue(True, 'OK');
end;

procedure TestTRecord.TestRetrieveRecordFunction;
var
  R : TRecord;
begin
  R := RetrieveRecordFunction;
  CheckEquals('test', R['Test'].AsString);
end;

procedure TestTRecord.Test_faulty_condition;
begin
  FDynamicRecord[TEST_STRING] := '';
  FRecord := FDynamicRecord;
  CheckEqualsString('', FRecord[TEST_STRING].AsString);

  FRecord[TEST_STRING] := 'New Value';
  CheckNotEqualsString('New Value', FDynamicRecord[TEST_STRING].AsString);

  FDynamicRecord[TEST_STRING] := 'Bad';
  CheckNotEqualsString('Bad', FRecord[TEST_STRING].AsString);

  FRecord := FDynamicRecord;
  FRecord[TEST_STRING] := 'Good';
  CheckEqualsString('Bad', FDynamicRecord[TEST_STRING].AsString);

  FDynamicRecord := FRecord;
  CheckEqualsString('Good', FDynamicRecord[TEST_STRING].AsString);

  FDynamicRecord[TEST_STRING] := 'Bad';
  CheckEqualsString('Good', FRecord[TEST_STRING].AsString);
end;

procedure TestTRecord.Test_From_method;
var
  R  : TRecord;
  O1 : TTestClass;
  O2 : TTestClass;
begin
  O1 := TTestUtils.CreateTestObject;
  try
    R.From(O1);
    O2 := TTestClass.Create;
    try
      R.AssignTo(O2);
      CheckEquals(O1.TestInteger, O2.TestInteger);
    finally
      O2.Free;
    end;
  finally
    O1.Free;
  end;
end;

procedure TestTRecord.Test_AssignTo_method_for_Object;
var
  R  : TRecord;
  O1 : TTestClass;
  O2 : TTestClass;
begin
  O1 := TTestUtils.CreateTestObject;
  try
    R.From(O1);
    O2 := TTestClass.Create;
    try
      R.AssignTo(O2);
      CheckTrue(O1.Equals(O2));
    finally
      O2.Free;
    end;
  finally
    O1.Free;
  end;
end;

procedure TestTRecord.Test_Assign_method_for_generic_IDynamicRecord_argument;
var
  DR : IDynamicRecord<TTestClass>;
begin
  DR := TRecord<TTestClass>.CreateDynamicRecord;
  DR.Data.TestString := 'Some teststring';
  DR.Data.TestChar   := 'A';
  FRecord.Assign(DR);
  CheckEquals(FRecord[TEST_STRING].AsString, DR.Data.TestString);
  CheckEquals(FRecord[TEST_CHAR].AsString, DR.Data.TestChar);
end;

procedure TestTRecord.Test_Assign_method_for_generic_TRecord_argument;
var
  R : TRecord<TTestClass>;
begin
  R.Data.TestString := 'Some teststring';
  R.Data.TestChar   := 'A';
  FRecord.Assign(R);
  CheckEquals(FRecord[TEST_STRING].AsString, R.Data.TestString);
  CheckEquals(FRecord[TEST_CHAR].AsString, R.Data.TestChar);
end;
{$ENDREGION}

end.

