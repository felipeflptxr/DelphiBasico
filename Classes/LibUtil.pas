unit LibUtil;

interface

uses
  Enumerados,

  Vcl.StdCtrls, FireDAC.Comp.Client, Vcl.ExtCtrls, FireDAC.Comp.DataSet,
  FireDAC.Stan.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Expr, FireDAC.Stan.ExprFuncs,
  Data.DB, Datasnap.DBClient, Winapi.ActiveX, System.Classes, Vcl.Forms, System.TypInfo,
  Winapi.Windows, Vcl.Dialogs, System.UITypes;

type
  Form = class
    {$REGION ' Form '}
    class function Abrir(mClasseForm: TComponentClass): TForm; overload;
    class function Abrir(mClasseForm: TComponentClass; mForm: TForm): TForm; overload;
    class function Get(mClasseForm: TComponentClass; mPodeFormShowModal: Boolean = False): TForm;
    {$ENDREGION}
  end;

  SQLParam = class
    {$REGION ' SQLParam '}
  private
    class procedure Substituir(mSQL: TStrings; mDe, mPor: String);
  public
    class function Data(mData: TDate): String; deprecated;
    class function Hora(mHora: TTime): String; deprecated;
    class function DataHora(mDataHora: TDateTime): String; deprecated;
    class function Texto(mTexto: String): String; deprecated;
    class function Inteiro(mInteiro: Int64): String; deprecated;
    class function Valor(mValor: Double; mDecimais: Integer = 2): String; deprecated;
    class function Boolean(mBoolean: Boolean; mAbreviado: Boolean = True): String; deprecated;

    class procedure SubstituirData(mSQL: TStrings; mDe: String; mData: TDate; mNuloSeVazio: Boolean = False);
    class procedure SubstituirHora(mSQL: TStrings; mDe: String; mHora: TTime; mNuloSeVazio: Boolean = False);
    class procedure SubstituirDataHora(mSQL: TStrings; mDe: String; mDataHora: TDateTime; mNuloSeVazio: Boolean = False);
    class procedure SubstituirTexto(mSQL: TStrings; mDe: String; mTexto: String;
      mNuloSeVazio: Boolean = False);
    class procedure SubstituirInteiro(mSQL: TStrings; mDe: String; mInteiro: Int64; mNuloSeVazio: Boolean = False);
    class procedure SubstituirValor(mSQL: TStrings; mDe: String;
      mValor: Double; mDecimais: Integer);
    class procedure SubstituirBoolean(mSQL: TStrings; mDe: String; mBoolean: Boolean;
      mAbreviado: Boolean = True);
    class procedure SubstituirInt64(mSQL: TStrings; mDe: String; mInt64: Int64);
    {$ENDREGION}
  end;

  Formatar = class
    {$REGION ' Formatar '}
    class function DataHora(
      mDataHora: TDateTime;
      mFormato: String = 'yyyy-mm-dd';
      mTamanho: Integer = 0;
      mCaracter: Char = ' ';
      mAlinharA: TTipoAlinhamentoCaracterFormatacao = tacfDireita): String;

    class function DataHoraAmigavel(
      mDataHora: TDateTime;
      mFormato: String = 'yyyy-mm-dd';
      mTamanho: Integer = 0;
      mCaracter: Char = ' ';
      mAlinharA: TTipoAlinhamentoCaracterFormatacao = tacfDireita): String;

    class function HoraDinamica(
      mHora: TTime): String;

    class function Texto(
      mTexto: String;
      mTamanho: Integer = 0;
      mCaracter: Char = ' ';
      mAlinharA: TTipoAlinhamentoCaracterFormatacao = tacfDireita): String;

    class function Inteiro(
      mInteiro: Integer;
      mTamanho: Integer = 0;
      mCaracter: Char = ' ';
      mAlinharA: TTipoAlinhamentoCaracterFormatacao = tacfEsquerda): String; overload;

    class function Inteiro(
      mInteiro: Integer;
      mFormatacao: String): String; overload;

    class function Valor(
      mValor: Double;
      mDecimais: Integer = 2;
      mFormatacao: TTipoFormatacaoValor = tfvVirgulaDecimalPontoMilhar;
      mTamanho: Integer = 0;
      mCaracter: Char = ' ';
      mAlinharA: TTipoAlinhamentoCaracterFormatacao = tacfEsquerda;
      mZeroVazio: Boolean = False): String;
    {$ENDREGION}
  end;

  TEditHelper = class Helper for TEdit
    {$REGION ' Helpers '}
    function ToInteger: Integer;
    function ToFloat: Double;
    function ToCurrency: Double;
    function IsEmpty: Boolean;
    function IsNotEmpty: Boolean;
    function CharLength: Integer;
    procedure IntToText(mValue: Integer);
    procedure FloatToText(mValue: Double);
    procedure CurrBRToText(mValue: Currency);
    {$ENDREGION}
  end;

  {$REGION ' Geral '}
  function Confirma(mPergunta: String): Boolean; overload;
  procedure Informa(mMensagem: String);
  procedure Alerta(mMensagem: String);
  procedure Erro(mMensagem: String);
  function MesAbreviado(mMes: Integer): String;
  function StrZero(Zeros: String; Quant: Integer): String; overload;
  function StrZero(Zeros: Integer; Quant: Integer): String; overload;
  function PegarCaracteres(const mStr: String; mListaCaracter: array of Char): String;
  {$ENDREGION}

const
  cgEnterEmString = #13#10;

implementation

uses
  System.SysUtils, System.StrUtils, System.DateUtils;

{$REGION ' Geral '}
function Confirma(mPergunta: String): Boolean; overload;
begin
  Result := (MessageDlg(mPergunta, mtConfirmation, [mbYes,mbNo], 0) = mrYes);
end;

procedure Informa(mMensagem: String);
begin
  MessageDlg(mMensagem, mtInformation,[mbOk], 0);
end;

procedure Alerta(mMensagem: String);
begin
  MessageDlg(mMensagem, mtWarning, [mbOk], 0);
end;

procedure Erro(mMensagem: String);
begin
  MessageDlg(mMensagem, mtError, [mbOk], 0);
end;

function MesAbreviado(mMes: Integer): String;
const
  NumMes: Array[1..12] of String =
    ('Jan','Fev','Mar','Abr','Mai','Jun',
     'Jul','Ago','Set','Out','Nov','Dez');
begin
  Result := NumMes[mMes];
end;

function StrZero(Zeros: String; Quant: Integer): String;
var
  I,Tamanho:integer;
  aux,aux1: string;
begin
  aux := zeros;
  aux1:= zeros;
  Tamanho := length(zeros);
  if Tamanho < Quant then
    begin
      zeros:='';
      for I:=1 to quant - tamanho do
        begin
          zeros := zeros + '0';
        end;

      aux := zeros + aux;
      Result := aux;
    end
  else
    Result := zeros;
end;

function StrZero(Zeros: Integer; Quant: Integer): String;
begin
  Result:= StrZero(IntToStr(Zeros), Quant);
end;

function PegarCaracteres(const mStr: String; mListaCaracter: array of Char): String;
var
  mI, mJ: Integer;
  mEstaNaLista: Boolean;
begin
  Result:= '';
  for mI:= 1 to Length(mStr) do
    begin
      mEstaNaLista:= False;
      for mJ:= 0 to High(mListaCaracter) do
        begin
          if (mStr[mI] = mListaCaracter[mJ]) then
            begin
              mEstaNaLista:= True;
              Break;
            end;
        end;

      if mEstaNaLista then
        Result:= Result + mStr[mI];
    end;
end;
{$ENDREGION}

{$REGION ' Form '}
class function Form.Abrir(mClasseForm: TComponentClass): TForm;
begin
  Result:= Form.Get(mClasseForm, False);
  if Assigned(Result) then
    begin
      if IsIconic(Result.Handle) then
        ShowWindow(Result.Handle, SW_SHOWNORMAL);

      Result.Show;
      Result.BringToFront;
      Exit;
    end;

  Application.CreateForm(mClasseForm, Result);

  Result.Show;
  Result.BringToFront;
end;

class function Form.Abrir(mClasseForm: TComponentClass; mForm: TForm): TForm;
begin
  Result := Form.Abrir(mClasseForm)
end;

class function Form.Get(mClasseForm: TComponentClass;
  mPodeFormShowModal: Boolean): TForm;
var
  mI: Integer;
  mFrm: TForm;
begin
  Result:= nil;
  for mI:= 0 to (Screen.FormCount - 1) do
    begin
      mFrm:= Screen.Forms[mI];
      if (mFrm is mClasseForm) and
         (mPodeFormShowModal or (not (fsModal in mFrm.FormState))) then
        begin
          Result:= mFrm;
          Exit;
        end;
    end;
end;
{$ENDREGION}

{$REGION ' SQLParam '}
class function SQLParam.Data(mData: TDate): String;
begin
  Result:= FormatDateTime('dd.mm.yyyy', mData);
  Result:= QuotedStr(Result);
end;

class function SQLParam.Hora(mHora: TTime): String;
begin
  Result:= FormatDateTime('hh:mm:ss', mHora);
  Result:= QuotedStr(Result);
end;

class function SQLParam.DataHora(mDataHora: TDateTime): String;
begin
  Result:= FormatDateTime('dd.mm.yyyy hh:mm:ss', mDataHora);
  Result:= QuotedStr(Result);
end;

class function SQLParam.Texto(mTexto: String): String;
begin
  Result:= QuotedStr(mTexto);
end;

class function SQLParam.Inteiro(mInteiro: Int64): String;
begin
  Result:= IntToStr(mInteiro);
end;

class function SQLParam.Valor(mValor: Double; mDecimais: Integer): String;
begin
  Result:= Formatar.Valor(mValor, mDecimais, tfvPontoDecimal);
end;

class function SQLParam.Boolean(mBoolean: Boolean; mAbreviado: Boolean = True): String;
begin
  if mAbreviado then
    Result:= QuotedStr(IfThen(mBoolean, 'T', 'F'))
  else
    Result:= IfThen(mBoolean, 'True', 'False');
end;

class procedure SQLParam.Substituir(mSQL: TStrings; mDe, mPor: String);
begin
  if (LeftStr(mDe, 1) <> ':') then
    mDe:= ':' + mDe;
  mSQL.Text:= StringReplace(mSQL.Text, mDe, mPor, [rfReplaceAll]);
end;

class procedure SQLParam.SubstituirData(mSQL: TStrings; mDe: String; mData: TDate; mNuloSeVazio: Boolean = False);
begin
  if mNuloSeVazio and (mData = 0) then
    Substituir(mSQL, mDe, 'NULL')
  else
    Substituir(mSQL, mDe, QuotedStr(FormatDateTime('dd.mm.yyyy', mData)));
end;

class procedure SQLParam.SubstituirHora(mSQL: TStrings; mDe: String; mHora: TTime; mNuloSeVazio: Boolean = False);
begin
  if mNuloSeVazio and (mHora = 0) then
    Substituir(mSQL, mDe, 'NULL')
  else
    Substituir(mSQL, mDe, QuotedStr(FormatDateTime('hh:mm:ss', mHora)));
end;

class procedure SQLParam.SubstituirDataHora(mSQL: TStrings; mDe: String; mDataHora: TDateTime; mNuloSeVazio: Boolean = False);
begin
  if mNuloSeVazio and (mDataHora = 0) then
    Substituir(mSQL, mDe, 'NULL')
  else
    Substituir(mSQL, mDe, QuotedStr(FormatDateTime('dd.mm.yyyy hh:mm:ss', mDataHora)));
end;

class procedure SQLParam.SubstituirTexto(mSQL: TStrings; mDe, mTexto: String;
  mNuloSeVazio: Boolean = False);
begin
  if mNuloSeVazio and (Trim(mTexto) = '') then
    Substituir(mSQL, mDe, 'NULL')
  else
    Substituir(mSQL, mDe, QuotedStr(mTexto));
end;

class procedure SQLParam.SubstituirInt64(mSQL: TStrings; mDe: String;
  mInt64: Int64);
begin
  Substituir(mSQL, mDe, IntToStr(mInt64));
end;

class procedure SQLParam.SubstituirInteiro(mSQL: TStrings; mDe: String; mInteiro: Int64; mNuloSeVazio: Boolean = False);
begin
  if mNuloSeVazio and (mInteiro = 0) then
    Substituir(mSQL, mDe, 'NULL')
  else
    Substituir(mSQL, mDe, IntToStr(mInteiro));
end;

class procedure SQLParam.SubstituirValor(mSQL: TStrings; mDe: String;
  mValor: Double; mDecimais: Integer);
begin
  Substituir(mSQL, mDe, Formatar.Valor(mValor, mDecimais, tfvPontoDecimal));
end;

class procedure SQLParam.SubstituirBoolean(mSQL: TStrings; mDe: String;
  mBoolean: Boolean; mAbreviado: Boolean = True);
begin
  if mAbreviado then
    Substituir(mSQL, mDe, QuotedStr(IfThen(mBoolean, 'T', 'F')))
  else
    Substituir(mSQL, mDe, QuotedStr(IfThen(mBoolean, 'TRUE', 'FALSE')));
end;
{$ENDREGION}

{$REGION ' Formatar '}
class function Formatar.DataHora(mDataHora: TDateTime;
  mFormato: String;
  mTamanho: Integer;
  mCaracter: Char;
  mAlinharA: TTipoAlinhamentoCaracterFormatacao): String;
begin
  if mDataHora <= 0 then
    Result:=''
  else if (Copy(mFormato, 1, 19) = 'yyyy-mm-ddThh:mm:ss') then
    Result:= FormatDateTime('yyyy-mm-dd', mDataHora) +
             'T' +
             FormatDateTime(Copy(mFormato, 12, MaxInt), mDataHora)
  else
    Result:= FormatDateTime(mFormato, mDataHora);

  if (mTamanho > 0) then
    begin
      if (Length(Result) > mTamanho) then
        Result:= Copy(Result, 1, mTamanho)
      else
        begin
          if (mAlinharA = tacfEsquerda) then
            Result:= StringOfChar(mCaracter, mTamanho-Length(Result)) + Result
          else
            Result:= Result + StringOfChar(mCaracter, mTamanho-Length(Result));
        end;
    end;
end;

class function Formatar.Texto(mTexto: String;
  mTamanho: Integer;
  mCaracter: Char;
  mAlinharA: TTipoAlinhamentoCaracterFormatacao): String;
begin
  Result:= mTexto;

  if (mTamanho > 0) then
    begin
      if (Length(Result) > mTamanho) then
        Result:= Copy(Result, 1, mTamanho)
      else
        begin
          if (mAlinharA = tacfEsquerda) then
            Result:= StringOfChar(mCaracter, mTamanho-Length(Result)) + Result
          else
            Result:= Result + StringOfChar(mCaracter, mTamanho-Length(Result));
        end;
    end;
end;

class function Formatar.DataHoraAmigavel(mDataHora: TDateTime; mFormato: String;
  mTamanho: Integer; mCaracter: Char;
  mAlinharA: TTipoAlinhamentoCaracterFormatacao): String;
begin
  if mDataHora <= 0 then
    Result:=''
  else if DateOf(mDataHora) = DateOf(Date) then
    Result:= 'Hoje'
  else if DateOf(mDataHora) = (DateOf(Date)-1) then
    Result:= 'Ontem'
  else if DateOf(mDataHora) = (DateOf(Date)+1) then
    Result:= 'Amanhã'
  else if mFormato.Trim = 'dd mmm' then
    Result := DayOf(mDataHora).ToString + ' ' + MesAbreviado(MonthOf(mDataHora))
  else
    Result:= FormatDateTime(mFormato, mDataHora);

  if (mTamanho > 0) then
    begin
      if (Length(Result) > mTamanho) then
        Result:= Copy(Result, 1, mTamanho)
      else
        begin
          if (mAlinharA = tacfEsquerda) then
            Result:= StringOfChar(mCaracter, mTamanho-Length(Result)) + Result
          else
            Result:= Result + StringOfChar(mCaracter, mTamanho-Length(Result));
        end;
    end;
end;

class function Formatar.HoraDinamica(mHora: TTime): String;
begin
  if mHora <= 0 then
    Exit('');

  Result := FormatDateTime('hh:mm:ss', mHora);
  mHora := StrToTime(Result);

  if mHora <= StrToTime('00:00:59')  then
    Result := RightStr(Result, 2)
  else if mHora <= StrToTime('00:59:59')  then
    Result := RightStr(Result, 5);
end;

class function Formatar.Inteiro(mInteiro: Integer; mFormatacao: String): String;
var
  mQtdeX, mPosPonto: Integer;
begin
  mQtdeX := Length(PegarCaracteres(mFormatacao, ['X']));
  if (Length(IntToStr(mInteiro)) > mQtdeX) then
    mFormatacao := StringOfChar('X', Length(IntToStr(mInteiro)) - mQtdeX) + mFormatacao;

  Result := StrZero(mInteiro, mQtdeX);

  mPosPonto := 0;
  while True do
    begin
      if (Pos('.', Copy(mFormatacao, mPosPonto + 1, MaxInt)) > 0) then
        begin
          mPosPonto := mPosPonto + Pos('.', Copy(mFormatacao, mPosPonto + 1, MaxInt));
          Insert('.', Result, mPosPonto)
        end
      else
        Break;
    end;
end;

class function Formatar.Inteiro(mInteiro, mTamanho: Integer;
  mCaracter: Char; mAlinharA: TTipoAlinhamentoCaracterFormatacao): String;
begin
  Result:= Formatar.Texto( IntToStr(mInteiro),
                           mTamanho,
                           mCaracter,
                           mAlinharA );
end;

class function Formatar.Valor(mValor: Double;
  mDecimais: Integer;
  mFormatacao: TTipoFormatacaoValor;
  mTamanho: Integer;
  mCaracter: Char;
  mAlinharA: TTipoAlinhamentoCaracterFormatacao;
  mZeroVazio: Boolean): String;
var
  mAux: String;
begin
  if mZeroVazio and (mValor=0) then
    mAux := ''
  else if (mFormatacao = tfvPontoDecimal) then               //AXXXYYY.ZZ
    begin
      mAux:= FormatFloat('#0.'+ StringOfChar('0', mDecimais), mValor);
      mAux:= StringReplace(mAux,',','.',[rfReplaceAll]);
    end
  else if (mFormatacao = tfvVirgulaDecimal)then              //AXXXYYY,ZZ
    mAux:= FormatFloat('##0.'+ StringOfChar('0', mDecimais), mValor)
  else if (mFormatacao = tfvVirgulaDecimalPontoMilhar) then  //A.XXX.YYY,ZZ
    mAux:= FormatFloat(',#0.'+ StringOfChar('0', mDecimais), mValor)
  else if (mFormatacao = tfvSemPontoSemVirgula) then         //AXXXYYYZZ
    begin
      mAux:= FormatFloat('#0.'+ StringOfChar('0', mDecimais), mValor);
      mAux:= StringReplace(mAux,',','',[rfReplaceAll]);
    end
  else
    raise Exception.Create('Formatação não definida (function "Formatar.Valor").');

  Result:= mAux;

  if (mTamanho > 0) then
    begin
      if (Length(Result) > mTamanho) then
        Result:= Copy(Result, 1, mTamanho)
      else
        begin
          if (mAlinharA = tacfEsquerda) then
            Result:= StringOfChar(mCaracter, mTamanho-Length(Result)) + Result
          else
            Result:= Result + StringOfChar(mCaracter, mTamanho-Length(Result));
        end;
    end;
end;
{$ENDREGION}

{$REGION ' Helpers '}
procedure TEditHelper.CurrBRToText(mValue: Currency);
begin
  Self.Text := FormatCurr('R$ #,##0.00', mValue);
end;

procedure TEditHelper.FloatToText(mValue: Double);
begin
  Self.Text := FloatToStr(mValue);
end;

procedure TEditHelper.IntToText(mValue: Integer);
begin
  Self.Text := IntToStr(mValue);
end;

function TEditHelper.IsEmpty: Boolean;
begin
  Result := (Trim(Self.Text) = '');
end;

function TEditHelper.IsNotEmpty: Boolean;
begin
  Result := (Trim(Self.Text) <> '');
end;

function TEditHelper.CharLength: Integer;
begin
  Result := Length(Self.Text);
end;

function TEditHelper.ToCurrency: Double;
begin
  Result := StrToCurrDef(Self.Text, 0.0);
end;

function TEditHelper.ToFloat: Double;
begin
  Result := StrToFloatDef(Self.Text, 0.0);
end;

function TEditHelper.ToInteger: Integer;
begin
  Result := StrToIntDef(Self.Text, 0);
end;

{$ENDREGION}

end.
