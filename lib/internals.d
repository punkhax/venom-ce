module lib.internals;

import core.sys.windows.windows;
import core.sys.windows.tlhelp32;
import core.sys.windows.winnls;

import std.conv;

// Offsets (change these)
size_t newValue = 133_337;
DWORD health = 0x0090001C;

DWORD grenadeAmmo = 0x00900074;
DWORD rifleAmmo = 0x00900070;
DWORD recoil_addr = 0x004C2EC3;

ubyte[] opcodes = [0x90, 0x90, 0x90, 0x90, 0x90];

DWORD getModuleBaseAddress(DWORD process, const(wchar)* modName)
{
    DWORD modBaseAddress = 0;
    HANDLE hSnap = CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, process);

    if (hSnap != INVALID_HANDLE_VALUE)
    {
        MODULEENTRY32 modEntry;
        modEntry.dwSize = MODULEENTRY32.sizeof;

        if (Module32First(hSnap, &modEntry))
        {
            do {
                if (to!string(modEntry.szModule) == to!string(modName))
                {
                    modBaseAddress = cast(DWORD)modEntry.modBaseAddr;
                    break;
                }
            } while (Module32Next(hSnap, &modEntry));
        }
        CloseHandle(hSnap);
    }

    return modBaseAddress;

}
