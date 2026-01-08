using System.Windows;

namespace MyWixV4WpfBA.BA;

public partial class MainWindow : Window
{
    public MainWindow()
    {
        InitializeComponent();
    }

    private void Exit_Click(object sender, RoutedEventArgs e)
    {
        Close();
    }
}
