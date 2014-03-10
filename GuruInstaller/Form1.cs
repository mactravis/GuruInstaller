using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Reflection;
using System.Diagnostics;
using Microsoft.SqlServer.Management.Common;
namespace GuruInstaller
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        private void clientinstallBtn_Click(object sender, EventArgs e)
        {
            InstallClient();
        }
        public void InstallClient()
        {
            serverloader.Visible = false;
            clientloader.Visible = true;
            serverwait.Visible = false;
            clientwait.Visible = true;


            string source = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location) + "\\SetupFiles\\Media";
            string destination = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location) + "\\SetupFiles\\Client\\program files\\Guru\\Media";

            if (!Directory.Exists(destination))
            {
                Directory.CreateDirectory(destination);
            }

            DirectoryInfo s = new DirectoryInfo(source);
            DirectoryInfo d = new DirectoryInfo(destination);

            Cursor.Current = Cursors.WaitCursor;            
            CopyFilesRecursively(s, d);
            Cursor.Current = Cursors.Default;


            RunClientSetup();
        }
        public void InstallServer()
        {
            string source = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location) + "\\SetupFiles\\Media";
            string destination = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location) + "\\SetupFiles\\Server\\program files\\Guru\\Media";
            DirectoryInfo s = new DirectoryInfo(source);
            DirectoryInfo d = new DirectoryInfo(destination);
            CopyFilesRecursively(s, d);


            String path = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
            if (!IsSqlInstalled())
            {
                serverloader.Visible = true;
                clientloader.Visible = false;
                serverwait.Visible = true;
                clientwait.Visible = false;
                clientwait.Text = "Installing Sql server";
                serverwait.Text = "Installing Sql server";

                // Install Sql Server
                if (IsWin8())
                {
                    try
                    {
                        string pathToDelete = @"C:\Program Files\Microsoft SQL Server\MSSQL11.MVSQLEXPRESS\MSSQL\DATA";
                        DeleteDirectory(pathToDelete);
                    }
                    catch
                    {
                    }
                    //install sql server 2012
                    ProcessStartInfo p = new ProcessStartInfo(path + "\\SetupFiles\\SQL2012s.exe", "/qs /ACTION=Install /FEATURES=SQLENGINE,REPLICATION,FULLTEXT,RS,BIDS,BOL,SSMS /INSTANCENAME=MVSQLEXPRESS /INSTANCEID=MVSQLEXPRESS /SECURITYMODE=SQL /SAPWD=F-phumepr2Ve /SQLSYSADMINACCOUNTS=Administrator /SQLSVCSTARTUPTYPE=Automatic /TCPENABLED=1 /IACCEPTSQLSERVERLICENSETERMS");
                    Process proc = new Process();
                    proc.StartInfo = p;
                    proc.Start();
                    proc.WaitForExit();

                    if (IsSqlInstalled())
                    {
                        RunServerSetup();
                    }
                    else
                    {
                        //MessageBox.Show("Setup was not succesfylly installed.");
                        serverloader.Visible = false;
                        serverwait.Visible = false;
                    }
                }
                else
                {
                    try
                    {
                        string pathToDelete = @"C:\Program Files\Microsoft SQL Server\MSSQL11.MVSQLEXPRESS\MSSQL\DATA";
                        DeleteDirectory(pathToDelete);
                    }
                    catch
                    {
                    }
                    //install sql server 2008
                    ProcessStartInfo p = new ProcessStartInfo(path + "\\SetupFiles\\SQL2008s.exe", "/qs /ACTION=Install /FEATURES=SQLENGINE,REPLICATION,FULLTEXT,RS,BIDS,BOL,SSMS /INSTANCENAME=MVSQLEXPRESS /INSTANCEID=MVSQLEXPRESS /SECURITYMODE=SQL /SAPWD=F-phumepr2Ve /SQLSYSADMINACCOUNTS=Administrator /SQLSVCSTARTUPTYPE=Automatic /TCPENABLED=1");
                    Process proc = new Process();
                    proc.StartInfo = p;
                    p.UseShellExecute = false;
                    proc.Start();
                    proc.WaitForExit();
                    if (IsSqlInstalled())
                    {
                        RunServerSetup();
                    }
                    else
                    {
                        serverloader.Visible = false;
                        serverwait.Visible = false;
                        MessageBox.Show("Setup was not succesfylly installed.");
                    }
                }
            }
            else
            {
                RunServerSetup();
            }

        }

        public static void CopyFilesRecursively(DirectoryInfo source, DirectoryInfo target)
        {
            foreach (DirectoryInfo dir in source.GetDirectories())
                try
                {
                    CopyFilesRecursively(dir, target.CreateSubdirectory(dir.Name));
                }
                catch
                {
                }

            foreach (FileInfo file in source.GetFiles())
                try
                {
                    file.CopyTo(Path.Combine(target.FullName, file.Name));
                }
                catch
                {
                }
        }

        public bool IsWin8()
        {
            Version win8version = new Version(6, 2, 9200, 0);

            if (Environment.OSVersion.Platform == PlatformID.Win32NT &&
                Environment.OSVersion.Version >= win8version)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool IsSqlInstalled()
        {
            Microsoft.Win32.RegistryKey key = Microsoft.Win32.Registry.LocalMachine.OpenSubKey("Software").OpenSubKey("Microsoft").OpenSubKey("Microsoft SQL Server");
            if (key != null)
            {
                key = key.OpenSubKey("MVSQLEXPRESS");
            }

            if (key == null)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        
        private void serverinstallBtn_Click(object sender, EventArgs e)
        {
            InstallClient();
        }
        
        private void pictureBox5_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        
        protected override void OnPaint(PaintEventArgs e)
        {
            TextRenderer.DrawText(e.Graphics, this.Text.ToString(), this.Font, ClientRectangle, Color.White);
        }
        
        private void clientinstallBtn_Click(object sender, EventArgs e)
        {
            InstallServer();
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            clientloader.Visible = false;
            clientwait.Visible = false;
            serverloader.Visible = false;
            serverwait.Visible = false;
        }

        public void RunClientSetup()
        {
            clientwait.Text = "Installing Guru V5.5.0";
            serverwait.Text = "Installing Guru V5.5.0";

            String path = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
            ProcessStartInfo p = new ProcessStartInfo(path + "\\SetupFiles\\Client\\Setup.exe");
            Process proc = new Process();
            proc.StartInfo = p;
            p.UseShellExecute = false;
            proc.Start();
            proc.WaitForExit();

          
            string destination = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location) + "\\SetupFiles\\Client\\program files\\Guru\\Media";

            //DeleteDirectory(destination+"\\CEP\\Mov");
            DeleteDirectory(destination + "\\Featured\\Mov");
            DeleteDirectory(destination + "\\Featured\\png");
            DeleteDirectory(destination + "\\form");
            DeleteDirectory(destination + "\\thumbnails");
            //DeleteDirectory(destination + "\\Sales");
            DeleteDirectory(destination + "\\Guru\\mov");
            DeleteDirectory(destination + "\\Guru\\png");
            DeleteDirectory(destination + "\\ImportedMovies");
            
            DeleteDirectory(destination + "\\Voice\\English Male");
            DeleteDirectory(destination + "\\Voice\\Spanish Female");


            serverloader.Visible = false;
            clientloader.Visible = false;
            serverwait.Visible = false;
            clientwait.Visible = false;
        }


        private void EmptyFolder(DirectoryInfo directoryInfo)
        {
            foreach (FileInfo file in directoryInfo.GetFiles())
            {

                file.Delete();
            }
            foreach (DirectoryInfo subfolder in directoryInfo.GetDirectories())
            {
                EmptyFolder(subfolder);
            }
        }

        public void RunServerSetup()
        {

            clientwait.Text = "Installing Guru V5.5.9";
            serverwait.Text = "Installing Guru V5.5.9";

            String path = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
            ProcessStartInfo p = new ProcessStartInfo(path + "\\SetupFiles\\Server\\Setup.exe");
            Process proc = new Process();
            proc.StartInfo = p;
            p.UseShellExecute = false;
            proc.Start();
            proc.WaitForExit();
            serverloader.Visible = false;
            clientloader.Visible = false;
            serverwait.Visible = false;
            clientwait.Visible = false;
        }

        public static void DeleteDirectory(string path)
        {
            DeleteDirectory(path, false);
        }

        public static void DeleteDirectory(string path, bool recursive)
        {
            // Delete all files and sub-folders?
            if (recursive)
            {
                // Yep... Let's do this
                var subfolders = Directory.GetDirectories(path);
                foreach (var s in subfolders)
                {
                    DeleteDirectory(s, recursive);
                }
            }

            // Get all files of the folder
            var files = Directory.GetFiles(path);
            foreach (var f in files)
            {
                // Get the attributes of the file
                var attr = File.GetAttributes(f);

                // Is this file marked as 'read-only'?
                if ((attr & FileAttributes.ReadOnly) == FileAttributes.ReadOnly)
                {
                    // Yes... Remove the 'read-only' attribute, then
                    File.SetAttributes(f, attr ^ FileAttributes.ReadOnly);
                }

                // Delete the file
                File.Delete(f);
            }

            // When we get here, all the files of the folder were
            // already deleted, so we just delete the empty folder
            Directory.Delete(path);
        }
    }
}
