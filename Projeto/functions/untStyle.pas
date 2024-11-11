unit untStyle;

interface

uses
    Winapi.Windows,

    System.SysUtils,
    System.Classes,

    Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Graphics, Vcl.ComCtrls,
    Vcl.DBGrids, Vcl.Grids

    ;

    function setStyleWindow(vfForm: TForm): string; // fun��o que padroniza a exibi��o dos objetos padr�o

    procedure setFBorder(vfForm: TForm; vfShape: TShape); // Ajusta o tamanho das bordas
    procedure setCButton(vfForm: TForm; vfButton: TSpeedButton); // Ajusta os padr�es dos bot�es
    procedure setPSButton(vfForm: TForm; vfShape: TShape);
    procedure setTitle(vfForm: TForm; vfTitle: TLabel); // Ajusta os padr�es do titulo

    procedure setAtdButton(vfForm: TForm);

    procedure setGradient(vfForm: TForm; vfPaint: TPaintBox; vfStartCl, vfEndCl: TColor);
    procedure setZebraDbg(vfDBGrid: TDBGrid; Sender: TObject;
        const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);



var
    vPanel      : TPanel;
    vShape      : TShape;
    vLabel      : TLabel;
    vListBox    : TListBox;
    vPaintBox   : TPaintBox;
    vColorEdge  : TColor;
    vSpeedButton: TSpeedButton;
    vPageControl: TPageControl;

    vI,    iPage: Integer;


implementation

uses untSource;

procedure setGradient(vfForm: TForm; vfPaint: TPaintBox; vfStartCl, vfEndCl: TColor);
var
    ACanvas: TCanvas;
    ARect: TRect;
    vI, rc, gc, bc, h: Integer;
begin
    {Esta dica mostra como criar um efeito degrad� em um Canvas qualquer.
    Neste caso, estamos utilizando um componente TPaintBox e o evento OnPaint.
    Dependendo da utiliza��o deste recurso, esta rotina pode ser adaptada para
    funcionar em um outro componente.}

    // verifica se foi dedinida uma cor
    if (vfStartCl = 0) then vfStartCl := sysColorGradientStart;
    if (vfEndCl = 0) then   vfEndCl   := sysColorGradientEnd;

    //
    ACanvas := vfPaint.Canvas;
    ARect   := vfPaint.ClientRect;

    h := ARect.Bottom - ARect.Top;

    { desenha o degrad� }
    for vI := 0 to (ARect.Bottom - ARect.Top) do
    begin
        rc := GetRValue(vfStartCl);
        gc := GetGValue(vfStartCl);
        bc := GetBValue(vfStartCl);

        rc := rc + (((GetRValue(vfEndCl) - rc) * (ARect.Top + vI)) div h);
        gc := gc + (((GetGValue(vfEndCl) - gc) * (ARect.Top + vI)) div h);
        bc := bc + (((GetBValue(vfEndCl) - bc) * (ARect.Top + vI)) div h);

        ACanvas.Brush.Style := bsSolid;
        ACanvas.Brush.Color := RGB(rc, gc, bc);
        ACanvas.FillRect(Rect(ARect.Left, ARect.Top + vI, ARect.Right, ARect.Top + vI + 1));
    end;
end;

function setStyleWindow(vfForm: TForm): string; // fun��o que padroniza a exibi��o dos objetos padr�o
begin
    // define o t�tulo do menu
    Result := vfForm.Caption;

    // varre o form verificando cada objeto existente
    for vI := 0 to vfForm.ComponentCount - 1 do
    begin
        // verifica se o objeto � um speedbutton
        if (vfForm.Components[vI] is TSpeedButton) then
        begin
            // define a variavel de shape com o nome do componente encontrado
            vSpeedButton := (vfForm.Components[vI] as TSpeedButton);

            // defini��es da borda
            setCButton(vfForm, vSpeedButton);
        end;

        // vefica se � um shape
        if (vfForm.Components[vI] is TShape) then
        begin
            // define a variavel de shape com o nome do componente encontrado
            vShape := (vfForm.Components[vI] as TShape);

            // defini��es da borda
            setFBorder(vfForm, vShape);

            // dos bot�es de a��o
            setPSButton(vfForm, vShape);
        end;

        // verifica se � um label
        if (vfForm.Components[vI] is TLabel) then
        begin
            // define a variavel de label com o nome do componente encontrado
            vLabel := (vfForm.Components[vI] as TLabel);

            // defini��es da borda
            setTitle(vfForm, vLabel);
        end;

        // defini��es das box atendimento e compromisso
        setAtdButton(vfForm);
    end;
end;

procedure setTitle(vfForm: TForm; vfTitle: TLabel);
begin
    // define a font
    vfTitle.Font.Name := gcFontName;

    // verifica se � o bot�o CloseForm
    if Copy(vfTitle.Hint, 1 , 8) = 'lblTitle' then
    begin
        // define o tamanho e a posi��o
        vfTitle.Top         := 1;
        vfTitle.Left        := 1;
        vfTitle.Width       := vfTitle.Parent.Width;

        vfTitle.Alignment   := taCenter;
        vfTitle.Font.Size   := 12;

        vfTitle.Color       := sysColorEmpresaPri; // sysColorEmpresaSec;
        vfTitle.Font.Color  := clWindow;           // sysColorEmpresaPri;

        vfTitle.Transparent := False;
    end;
end;

procedure setFBorder(vfForm: TForm; vfShape: TShape);
begin
    // seta as defini��es da borda
    if Copy(vfShape.Hint, 1, 7) = 'shpEdge' then
    begin
        // redimenciona e posiciona o shape para fazer o fundo do bot�o
        vfShape.Top       := 0;
        vfShape.Left      := 0;
        vfShape.Width     := vfShape.Parent.Width;
        vfShape.Height    := vfShape.Parent.Height;
//        vfShape.pen.Color := $00448F0B;
    end;

    vfShape.pen.Color := $00448F0B;
end;

procedure setPSButton(vfForm: TForm; vfShape: TShape);
begin
    if ((LowerCase(Copy(vfShape.Hint, 1, 6)) = 'button') or
            {(LowerCase(Copy(vfShape.Name, 1, 7)) = 'shpedge') or}
            (LowerCase(Copy(vfShape.Hint, 1, 7)) = 'shpedge')) then
    begin
        // redimenciona e posiciona o shape para fazer o fundo do bot�o
        vfShape.Top    := 0;
        vfShape.Left   := 0;
        vfShape.Width  := vfShape.Parent.Width;
        vfShape.Height := vfShape.Parent.Height;

        // verifica se � um bot�o
        if (LowerCase(Copy(vfShape.Hint, 1, 6)) = 'button') then
            // se for o bot�o prim�rio
            if (LowerCase(Copy(vfShape.Hint, 7, 100)) = 'primary') then
                vfShape.Brush.Color := sysColorButtonPrimary
            // se for o bot�o secund�rio
            else if (LowerCase(Copy(vfShape.Hint, 7, 100)) = 'secondary') then
                vfShape.Brush.Color := sysColorButtonSecondary;
    end;
end;

procedure setCButton(vfForm: TForm; vfButton: TSpeedButton);
begin
    // defione a font do bot�o
    vSpeedButton.Font.Name := gcFontName;

    // verifica se � o bot�o CloseForm
    if (vSpeedButton.Name = 'btnCloseForm') then
    begin
        // define o tamanho do bot�o
        vSpeedButton.Font.Size := 12;

        // redimenciona e posiciona o bot�o
        vSpeedButton.Height := 30;
        vSpeedButton.Width  := 45;
        vSpeedButton.Top    := 0;
        vSpeedButton.Left   := vSpeedButton.Parent.Width - 45;
    end;
end;

procedure setAtdButton(vfForm: TForm);
begin
    // verifica se o objeto � um speedbutton
    if (vfForm.Components[vI] is TSpeedButton) then
    begin
        // define a variavel de shape com o nome do componente encontrado
        vSpeedButton := (vfForm.Components[vI] as TSpeedButton);

        // verifica se � o bot�o da lista de atendimento
        if vSpeedButton.Hint = 'btnAtd' then
        begin
            // ajusta a trasnpar�ncia
            vSpeedButton.Flat := True;

            // remove o texto
            vSpeedButton.Caption := '';

            // posiciona o bit�o
            vSpeedButton.top    := 2;
            vSpeedButton.Left   := 2;
            vSpeedButton.Height := vSpeedButton.Parent.Height - 2;
            vSpeedButton.Width  := vSpeedButton.Parent.Width - 2;
        end;
    end;

    // vefica se � um shape
    if (vfForm.Components[vI] is TShape) then
    begin
        // define a variavel de shape com o nome do componente encontrado
        vShape := (vfForm.Components[vI] as TShape);

        if vShape.Hint = 'shpAtd' then
        begin
            // posiciona o bit�o
            vShape.top    := 0;
            vShape.Left   := 0;
            vShape.Height := vShape.Parent.Height;
            vShape.Width  := vShape.Parent.Width;
        end;
    end;

    // vefica se � um shape
    if (vfForm.Components[vI] is TLabel) then
    begin
        // define a variavel de shape com o nome do componente encontrado
        vLabel := (vfForm.Components[vI] as TLabel);

        if (vLabel.Hint = 'lblAtdHora') or
            (vLabel.Hint = 'lblAtdCliente') then
        begin
            // formata a label hora
            if (vLabel.Hint = 'lblAtdHora') then
            begin
                vLabel.Font.Color := $002A5320;
                vLabel.Font.Size  := 16;
                vLabel.Font.Style := [fsBold];
            end;

            // formata a label cliente
            if (vLabel.Hint = 'lblAtdCliente') then
            begin
                vLabel.Font.Size  := 14;
            end;
        end;
    end;
end;

procedure setZebraDbg(vfDBGrid: TDBGrid; Sender: TObject;
    const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    // define o padr�o da zebra
    if Odd(vfDBGrid.DataSource.DataSet.RecNo) then
        vfDBGrid.Canvas.Brush.Color := $00CAEBD1
    else
        vfDBGrid.Canvas.Brush.Color := clWhite;

    // cofigura a cor do highligth
    if (gdSelected in State) then
    begin
        vfDBGrid.Canvas.Brush.Color := $0048B74B;
        vfDBGrid.Canvas.Font.Color  := clWhite;
        vfDBGrid.Canvas.Font.Style  := [fsBold];
    end;

    // seta as configura��es
    vfDBGrid.Canvas.FillRect(Rect);
    vfDBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;



end.

//##############################################################################
//##############################################################################
//##############################################################################
//##############################################################################

