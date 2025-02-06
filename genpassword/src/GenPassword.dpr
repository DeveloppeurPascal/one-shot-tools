/// <summary>
/// ***************************************************************************
///
/// One Shot Tools
///
/// Copyright 2022-2024 Patrick PREMARTIN under AGPL 3.0 license.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
/// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
/// ***************************************************************************
///
/// projects for a unique (or very little number of) usage
///
/// ***************************************************************************
///
/// Author(s) :
/// Patrick PREMARTIN
///
/// Site :
/// https://oneshottools.developpeur-pascal.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/one-shot-tools
///
/// ***************************************************************************
/// File last update : 2025-02-05T21:09:26.281+01:00
/// Signature : 04884ab13cc1e97909a2ad705d27feb63343595f
/// ***************************************************************************
/// </summary>

program GenPassword;

uses
  Forms,
  uGenPassword in 'uGenPassword.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
