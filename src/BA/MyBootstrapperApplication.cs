using System;
using WixToolset.BootstrapperApplicationApi;
using WixToolset.BootstrapperApplicationCore;

namespace MyWixV4WpfBA.BA;

/// <summary>
/// Minimal WiX v4 managed BootstrapperApplication.
/// 
/// Notes:
/// - Burn will create this type via reflection.
/// - A full implementation should handle Detect/Plan/Apply and drive the WPF UI.
/// - This skeleton keeps things simple and is intended as a starting point.
/// </summary>
public class MyBootstrapperApplication : BootstrapperApplication
{
    protected override void Run()
    {
        Engine.Log(LogLevel.Standard, "MyBootstrapperApplication starting.");

        // Basic event wiring (expand as needed)
        this.DetectComplete += (_, e) => Engine.Log(LogLevel.Standard, $"DetectComplete: Status={e.Status}");
        this.PlanComplete += (_, e) => Engine.Log(LogLevel.Standard, $"PlanComplete: Status={e.Status}");
        this.ApplyComplete += (_, e) => Engine.Log(LogLevel.Standard, $"ApplyComplete: Status={e.Status}");

        // Kick off initial detect.
        Engine.Detect();

        // Show a simple WPF window. In a real BA, you would run a message loop and
        // drive plan/apply from UI commands.
        var app = new App();
        var window = new MainWindow();
        app.Run(window);

        Engine.Quit(0);
    }
}
