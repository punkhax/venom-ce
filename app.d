import core.sys.windows.windows;
import core.sys.windows.psapi;

import std.stdio;
import std.utf;
import std.string;

import lib.internals;

pragma(lib, "gdi32.lib");
pragma(lib, "user32.lib");
pragma(lib, "psapi.lib");

void main()
{
	HWND hwnd = FindWindowA(null, "AssaultCube".toStringz);

	if (!hwnd)
	{
		writeln("[venom] AssaultCube not found.");
	}
	else 
	{
		writeln("[venom] AssaultCube found!");
		writeln("[venom] Initializing Cheat Engine..");
	}

	DWORD pID;

	GetWindowThreadProcessId(hwnd, &pID);
	if (pID == 0)
	{
		writeln("[venom] Unable to find process ID.");
	}
	else 
	{
		writeln("[venom] Process ID: ", pID);
	}

	HANDLE handle = OpenProcess(PROCESS_ALL_ACCESS, false, pID);

	DWORD baseAddress = getModuleBaseAddress(pID, "ac_client.exe".toUTF16z);
	writeln("[venom] Base Address: 0x", &baseAddress);

	if (WriteProcessMemory(handle, cast(void*)recoil_addr, opcodes.ptr, opcodes.length, null) == false)
	{
		writeln("[venom] Unable to enable No Recoil.");
	}
	else
	{
		writeln("[venom] No recoil enabled!");
	}

	if (WriteProcessMemory(handle, cast(void*)health, &newValue, newValue.sizeof, null) == false)
	{
		writeln("[venom] Unable to enable God Mode.");
	}
	else
	{
		writeln("[venom] Successfully enabled God Mode!");
	}

	if (WriteProcessMemory(handle, cast(void*)rifleAmmo, &newValue, newValue.sizeof, null) == false)
	{
		writeln("[venom] Unable to enable Infinite Ammo.");
	}
	else
	{
		writeln("[venom] Successfully enabled Infinite Ammo");
	}

	if (WriteProcessMemory(handle, cast(void*)grenadeAmmo, &newValue, newValue.sizeof, null) == false)
	{
		writeln("[venom] Unable to enable Infinite Grenades.");
	}
	else
	{
		writeln("[venom] Successfully enabled Infinite Grenades!");
	}
}