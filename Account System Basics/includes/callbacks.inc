#include <YSI_Coding\y_hooks>

hook OnScriptInit()
{
    // Initialisasikan terlebih dahulu sebuah iterasinya
    Iter_Init(LoggedInPlayers);

    // Baru kita menginitialisasikan script utama
    // bisa juga menggunakan timer jika ingin terlihat
    // lebih singkron XD
    
    InitAccountSystem();
    // SetTimer("InitAccountSystem", 2000, false);

    print("\n----------------------------------");
    print("       Account System\n");
    print("         Written by");
    print("         rsetiawan7");
    print("----------------------------------\n");
    return 1;
}

hook OnScriptExit()
{
    //P:4 itu adalah sebuah fungsi print di YSI dengan security level 4 (debug)
    P:4("Start to save logged in's player data");

    // Disini kita menggunakan foreach a.k.a y_iterate
    // foreach sangat bagus ketimbang menggunakan lainnya karena terbilang cukup
    // unik seperti hanya mengembalikan nilai dengan lompat2.
    
    foreach (new playerid : LoggedInPlayers)
    {
        P:4("Saving player data with Player ID: %i ...", playerid);

        // Anggaplah disini player masih login, dan anda simpan data
        // player yang tersedia fungsi ini, lalu kita bisa menambahkan
        // sebuah variabel untuk mengambil nilai yang telah dikeluarkan oleh
        // fungsi tersebut.
        
        new saveable = SavePlayerCharacterData(playerid);

        P:4("Save player data with Player ID: %i result --> %i", saveable);
    }

    // Kalau sudah tinggal di tutup saja sistemnya.
    CloseAccountSystem();

    return 1;
}
