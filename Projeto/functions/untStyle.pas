unit untStyle;

interface

uses
    Winapi.Windows,
//    Winapi.ShellAPI,
//    Winapi.Messages,

//  System.Variants,
  System.SysUtils,
  System.Classes,

//    Vcl.Dialogs,
//    Vcl.Controls,
//    Vcl.Dialogs,
    Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Graphics,
    Vcl.ComCtrls

  ;

    function setStyleWindow(vfForm: TForm): string; // função que padroniza a exibição dos objetos padrão

{
    function GetBuildInfo(ProgamName: string): string; // função que pega as informações de versão do sistema
    function setWindowDefaults(vfForm: TForm): string; // função que padroniza a exibição dos objetos padrão
    function setViewPageControl(vfForm: TForm): Boolean; // função para moldar as definições iniciais do pagecontrol
    function setColorPageControl(vfForm: TForm; vfPageControl: TPageControl): Boolean; // função que define as cores dos botões do pagecontrol

    procedure BorderShape(vfForm: TForm); // Ajusta o tamanho das bordas
    procedure setMenu(vfForm: TForm); // função que configura o tamanho do menu
    procedure allMenu(vfForm: TForm); // função que fecha o menu

    procedure ListView(vfForm: TForm); // função que exibe/oculta os itens da lista

}

var
    vPanel      : TPanel;
    vShape      : TShape;
    vLabel      : TLabel;
    vListBox    : TListBox;
    vColorEdge  : TColor;
    vSpeedButton: TSpeedButton;
    vPageControl: TPageControl;

    vI,    iPage: Integer;


implementation

uses untConstants;

function setStyleWindow(vfForm: TForm): string; // função que padroniza a exibição dos objetos padrão
begin
    // define o título do menu
    Result := vfForm.Caption;

    // varre o form verificando cada objeto existente
    for vI := 0 to vfForm.ComponentCount - 1 do
    begin

        // verifica se o objeto é um speedbutton
        if (vfForm.Components[vI] is TSpeedButton) then
        begin
            // define a variavel de shape com o nome do componente encontrado
            vSpeedButton := (vfForm.Components[vI] as TSpeedButton);

            // defione a font do botão
            vSpeedButton.Font.Name := gcFontName;

            // verifica se é o botão CloseForm
            if (vSpeedButton.Name = 'btnCloseForm') then
            begin
                // define o tamanho do botão
                vSpeedButton.Font.Size := 12;

                // redimenciona e posiciona o botão
                vSpeedButton.Height := 30;
                vSpeedButton.Width  := 45;
                vSpeedButton.Top    := 0;
                vSpeedButton.Left   := vSpeedButton.Parent.Width - 45;
            end;
        end;

    end;
end;

end.








  (*

      *)
function setWindowDefaults(vfForm: TForm): string;
begin

    // define a cor para tema claro
    vColorEdge := sysColorEdge;

    // passa por cada componente do form
    for vI := 0 to vfForm.ComponentCount - 1 do
    begin

        // vefica se é um shape
        if (vfForm.Components[vI] is TShape) then
        begin
            // define a variavel de shape com o nome do componente encontrado
            vShape := (vfForm.Components[vI] as TShape);

            // define a cor da borda
            vShape.Pen.Color := vColorEdge;

            // verifica se é
            if (vShape.Name = 'shpTitleForm') then
            begin
                //
            end
            else if ((LowerCase(Copy(vShape.Hint, 1, 6)) = 'button') or
                      {(LowerCase(Copy(vShape.Name, 1, 7)) = 'shpedge') or}
                       (LowerCase(Copy(vShape.Hint, 1, 7)) = 'shpedge')) then
            begin
                // redimenciona e posiciona o shape para fazer o fundo do botão
                vShape.Top    := 0;
                vShape.Left   := 0;
                vShape.Width  := vShape.Parent.Width;
                vShape.Height := vShape.Parent.Height;

                // verifica se é um botão
                if (LowerCase(Copy(vShape.Hint, 1, 6)) = 'button') then
                    // se for o botão primário
                    if (LowerCase(Copy(vShape.Hint, 7, 100)) = 'primary') then
                        vShape.Brush.Color := sysColorButtonPrimary
                    // se for o botão secundário
                    else if (LowerCase(Copy(vShape.Hint, 7, 100)) = 'secondary') then
                        vShape.Brush.Color := sysColorButtonSecondary;
            end;
        end;

        // verifica se é um label
        if (vfForm.Components[vI] is TLabel) then
        begin
            // define a variavel de shape com o nome do componente encontrado
            vLabel := (vfForm.Components[vI] as TLabel);

            // define a font
            vLabel.Font.Name := gcFontName;

            // verifica se é o botão CloseForm
            if Copy(vLabel.Hint, 1 , 8) = 'lblTitle' then
            begin
                // define o tamanho e a posição
                vLabel.Top         := 1;
                vLabel.Left        := 1;
                vLabel.Width       := vLabel.Parent.Width;

                vLabel.Alignment   := taCenter;
                vLabel.Font.Size   := 12;

                vLabel.Color       := sysColorEmpresaPri; // sysColorEmpresaSec;
                vLabel.Font.Color  := clWindow;           // sysColorEmpresaPri;

                vLabel.Transparent := False;
            end;
        end;
    end;
end;

function setViewPageControl(vfForm: TForm): Boolean;
begin
    // passa por cada componente do form
    for vI := 0 to vfForm.ComponentCount - 1 do
    begin
        // verifica se é um pagecontrol
        if (vfForm.Components[vI] is TPageControl) then
        begin
            // define a variavel com o componente encontrado
            vPageControl := (vfForm.Components[vI] as TPageControl);

            if (Copy(vPageControl.StyleName, 1, 10) = 'pgcControl') then
            begin
                //
                for iPage := 0 to vPageControl.PageCount - 1 do
                    // oculta as guias
                    vPageControl.Pages[iPage].TabVisible := False;

                // exibe a guia
                vPageControl.ActivePageIndex := 0;
            end;
        end;
    end;
end;

function setColorPageControl(vfForm: TForm; vfPageControl: TPageControl): Boolean;
begin
    // passa por cada componente do form
    for vI := 0 to vfForm.ComponentCount - 1 do
    begin
        if (vfForm.Components[vI] is TPanel) then
        begin
            // define a variavel com o componente encontrado
            vPanel := (vfForm.Components[vI] as TPanel);

            if (vPanel.Hint = 'btnPageControl') then
            begin
                // verifica se o panel é o que foi clicado e define a cor
                if vPanel.Tag = vfPageControl.ActivePageIndex then
                    vPanel.Color := $0098593B
                else
                    vPanel.Color := $00C39D8B;
            end;
        end;
    end;
end;

procedure setMenu(vfForm: TForm);
var
    vH: integer;
begin
    // inicializa a variavel
    vH := 0;

    // passa por cada componente do form
    for vI := 0 to vfForm.ComponentCount - 1 do
    begin
        // verifica se é um panel
        if (vfForm.Components[vI] is TPanel) then
        begin
            // define a variavel com o componente encontrado
            vPanel := (vfForm.Components[vI] as TPanel);

            // verifica se é um item do menu
            if vPanel.Hint = 'mniButton' then
            begin
                // zera o tamanho da borda
                vPanel.Parent.Height := 0;

                // verifica se o panel está visível
                if vPanel.Visible then
                    // define o tamanho do panel
                    vH := vH + (vPanel.Height + vPanel.Margins.Bottom + vPanel.Margins.Top);

                // seta o tamanho do panel
                vPanel.Parent.Height := vh;
            end;
        end;
    end;


    // passa por cada componente do form
    for vI := 0 to vfForm.ComponentCount - 1 do
    begin
        // verifica se é um panel
        if (vfForm.Components[vI] is TShape) then
        begin
            // define a variavel com o componente encontrado
            vShape := (vfForm.Components[vI] as TShape);

            // verifica se é a borda do menu
            if vShape.Name = 'shpEdgeMenu' then
            begin
                vShape.Top    := 0;
                vShape.Left   := 0;
                vShape.Width  := vShape.Parent.Width;
                vShape.Height := vShape.Parent.Height;
            end;
        end;
    end;
end;

procedure allMenu(vfForm: TForm);
begin
    // passa por cada componente do form
    for vI := 0 to vfForm.ComponentCount - 1 do
    begin
        // verifica se é um panel
        if (vfForm.Components[vI] is TPanel) then
        begin
            // define a variavel com o componente encontrado
            vPanel := (vfForm.Components[vI] as TPanel);

            // verifica se é um item do menu
            if Copy(vPanel.Name, 1, 7) = 'pnlMenu' then
                // torma o panel invisível
                vPanel.Visible := False;
        end;
    end;
end;


procedure ListView(vfForm: TForm);
begin
    // passa por cada componente do form
    for vI := 0 to vfForm.ComponentCount - 1 do
    begin
        // verifica se é um panel
        if (vfForm.Components[vI] is TListBox) then
        begin
            // define a variavel com o componente encontrado
            vListBox := (vfForm.Components[vI] as TListBox);

            if vListBox.Hint <> '' then
            begin
                // verifica se há registro
                if (vListBox.Items.Count > 0) then
                    vListBox.Parent.Tag := 100 // define o tamanho
                else
                    vListBox.Parent.Tag := 35; // define o tamanho

                // seta o tamanho
                vListBox.Parent.Height := vListBox.Parent.Tag;
            end;
        end;
{
        // verifica se é um panel
        if (vfForm.Components[vI] is TShape) then
        begin
            // define a variavel com o componente encontrado
            vShape := (vfForm.Components[vI] as TShape);

            // verifica se o shape é um titulo
            if (vShape.Hint = 'shpTitle') then
                if (vShape.Parent.Height > 35) then
                    vShape.Height := 1
                else
                    vShape.Height := 0;
        end;
}
    end;

    // atualiza a tela
//    setWindowDefaults(vfForm);
    BorderShape(vfForm);
end;

procedure BorderShape(vfForm: TForm);
begin
    for vI := 0 to vfForm.ComponentCount -1 do
    begin
        // vefica se é um shape
        if (vfForm.Components[vI] is TShape) then
        begin
            // define a variavel de shape com o nome do componente encontrado
            vShape := (vfForm.Components[vI] as TShape);

            //
            if Copy(vShape.Hint, 1, 7) = 'shpEdge' then
            begin
                // redimenciona e posiciona o shape para fazer o fundo do botão
                vShape.Top    := 0;
                vShape.Left   := 0;
                vShape.Width  := vShape.Parent.Width;
                vShape.Height := vShape.Parent.Height;
            end;
        end;
    end;
end;

end.

