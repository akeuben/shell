namespace Passwd {
    [CCode (cheader_filename = "pwd.h", cname = "struct passwd")]
    public struct PasswdEntry {
        public string pw_name;
        public string pw_passwd;
        public uint pw_uid;
        public uint pw_gid;
        public string pw_gecos;
        public string pw_dir;
        public string pw_shell;
    }

    [CCode (cname = "setpwent", cheader_filename = "pwd.h")]
    public static void setpwent();

    [CCode (cname = "getpwent", cheader_filename = "pwd.h")]
    public static unowned PasswdEntry? getpwent();

    [CCode (cname = "endpwent", cheader_filename = "pwd.h")]
    public static void endpwent();
}
