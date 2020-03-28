// SA-MP Core
#include <a_samp>

// Hapus ini jika tidak mau menggunakan SQLITE
#define USE_SQLITE

// Plug-ins lain
#include <hash>
#include <YSI-Core/y_debug>
#include <YSI-Data/y_iterate>
#include <YSI-Coding/y_remote>
#include <YSI-Coding/y_timers>
#include <YSI-Visual/y_commands>

/*
 Kita gunakan y_testing untuk mengetes
 apakah apa yang kita buat work atau tidak
 
 NOTE: jangan pernah gunakan y_testing ketika
 gak buat ngetest code apapun.
*/
#define RUN_TESTS
#include <YSI-Core/y_testing>

// Wajib deklarasikan main() agar tidak terjadi error
// Ketika ingin membuat gamemode.
main()
{
    print("\n------------------------------------");
    print("       Account System (Unit Testing)\n");
    print("              Written by");
    print("              rsetiawan7");
    print("------------------------------------\n");
}

// Untuk coding lebih rapih lagi, mari kita gunakan sebuah
// Metode yaitu "Modular Scripting"...

//Silahkan buka functions.inc untuk lihat lebih jelasnya.
#include "includes/functions.inc"

//disini anggap saja kalian mempunyai akun dan tersimpan disini
static
        testUsername[11] = "GameDev123",
        testPassword[18] = "itisonlyapassword",
        testEmail[17] = "gamedev@samp.dev";
/*
  Disini terdiri dari beberapa test yang bisa dilihat
  saat anda menjalankan samp-server.exe
  
  Jadi silahkan lihat bagaimana hasilnya!
  
  NOTE: penting untuk diketahui bahwa
  menggunakan ASSERT sebagai penganti if
  jika tidak digunakan untuk testing
  maka sama saja seperti kalian menaruh
  bomb di laptop kalian..
*/

Test:AddAccountWithoutUsername() {
    ASSERT(AddPlayerAccount("", testPassword, testEmail) == E_USERNAME_REQUIRED);
    return true;
}

Test:AddAccountWithoutPassword() {
    ASSERT(AddPlayerAccount(testUsername, "", testEmail) == E_PASSWORD_REQUIRED);
    return true;
}

Test:AddAccountWithLessPasswordLength() {
    static
        randomPassword[MIN_PASSWORD_LENGTH];
    
    random_string(sizeof(randomPassword) - 1, randomPassword, sizeof(randomPassword) - 1);
    ASSERT(AddPlayerAccount(testUsername, randomPassword, testEmail) == E_INSUFFICIENT_PASSWORD_LENGTH);
    return true;
}

Test:AddAccountWithExceedPasswordLength() {
    static
        randomPassword[MAX_PASSWORD_LENGTH + 6];
    
    random_string(sizeof(randomPassword) - 1, randomPassword, sizeof(randomPassword) - 1);
    ASSERT(AddPlayerAccount(testUsername, randomPassword, testEmail) == E_EXCEED_PASSWORD_LENGTH);
    return true;
}

Test:AddAccountWithoutEmailAddress() {
    ASSERT(AddPlayerAccount(testUsername, testPassword, "") == E_EMAIL_REQUIRED);
    return true;
}

Test:AddAccount() {
    ASSERT(AddPlayerAccount(testUsername, testPassword, testEmail) == 1);
    return true;
}

Test:LogInWithoutUsername() {
    ASSERT(LogInPlayerAccount(0, "", testPassword) == E_USERNAME_REQUIRED);
    return true;
}

Test:LogInWithoutPassword() {
    ASSERT(LogInPlayerAccount(0, testUsername, "") == E_PASSWORD_REQUIRED);
    return true;
}

Test:LogInWithLessPasswordLength() {
    static
        randomPassword[MIN_PASSWORD_LENGTH];
    
    random_string(sizeof(randomPassword) - 1, randomPassword, sizeof(randomPassword) - 1);
    ASSERT(LogInPlayerAccount(0, testUsername, randomPassword) == E_INSUFFICIENT_PASSWORD_LENGTH);
    return true;
}

Test:LogInWithExceedPasswordLength() {
    static
        randomPassword[MAX_PASSWORD_LENGTH + 6];
    
    random_string(sizeof(randomPassword) - 1, randomPassword, sizeof(randomPassword) - 1);
    ASSERT(LogInPlayerAccount(0, testUsername, randomPassword) == E_EXCEED_PASSWORD_LENGTH);
    return true;
}

Test:LogInWithInvalidPassword() {
    static
        randomPassword[MAX_PASSWORD_LENGTH - 8];
    
    random_string(sizeof(randomPassword), randomPassword, sizeof(randomPassword));
    ASSERT(LogInPlayerAccount(0, testUsername, randomPassword) == E_INVALID_CREDENTIAL);
    return true;
}

Test:LogInWithValidAccount() {
    ASSERT(LogInPlayerAccount(0, testUsername, randomPassword) == 1);
    return true;
}

Test:LogInTwice() {
    ASSERT(LogInPlayerAccount(0, testUsername, randomPassword) == E_PLAYER_ALREADY_LOGGED_IN);
    return true;
}

Test:LogOut() {
    ASSERT(LogOutFromPlayerAccount(0) == 1);
    return true;
}

Test:LogOutTwice() {
    ASSERT(LogOutFromPlayerAccount(0) == E_PLAYER_NOT_LOGGED_IN);
    return true;
}

// Callbacks
// #include "lsdm/callbacks.inc"

// Timers
// #include "lsdm/timers.inc"
