using System;
using System.Threading;
using System.Windows;
using WixToolset.BootstrapperApplicationApi;

namespace MyBA
{
    /// <summary>
    /// Managed BA entry point loaded by bal:ManagedBootstrapperApplicationHost.
    /// This BA hosts a WPF window without using ApplicationDefinition as the entry point.
    /// </summary>
    public sealed class MyBootstrapperApplication : BootstrapperApplication
    {
        private Thread? _uiThread;

        protected override void Run()
        {
            // Start WPF UI on an STA thread.
            _uiThread = new Thread(() =>
            {
                var app = new App
                {
                    ShutdownMode = ShutdownMode.OnMainWindowClose
                };

                var window = new MainWindow();
                app.MainWindow = window;
                window.Show();

                // Typically you'd wire up Engine events -> UI viewmodel here.
                app.Run();
            });

            _uiThread.SetApartmentState(ApartmentState.STA);
            _uiThread.IsBackground = false;
            _uiThread.Start();

            // Wait for UI to exit.
            _uiThread.Join();

            Engine.Quit(0);
        }
    }
}
