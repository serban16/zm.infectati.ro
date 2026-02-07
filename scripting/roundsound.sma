//RoundSound.amxx -by PaintLancer

#include <amxmodx>

public plugin_init() 
{ 
  register_plugin("RoundSound","1.0","PaintLancer")
  register_event("SendAudio", "t_win", "a", "2&%!MRAD_terwin")
  register_event("SendAudio", "ct_win", "a", "2&%!MRAD_ctwin")  
}

public t_win()
{
  new rand = random_num(0,2)

  client_cmd(0,"stopsound")

  switch(rand)
  {
    case 0: client_cmd(0,"spk misc/twinnar")
    case 1: client_cmd(0,"spk misc/twinnar2")
    case 2: client_cmd(0,"spk misc/twinnar3")
  }

  return PLUGIN_HANDLED
}

public ct_win()
{
  new rand = random_num(0,2)

  client_cmd(0,"stopsound")

  switch(rand)
  {
    case 0: client_cmd(0,"spk misc/ctwinnar2")
    case 1: client_cmd(0,"spk misc/ctwinnar3")
    case 2: client_cmd(0,"spk misc/ctwinnar4")
  }

  return PLUGIN_HANDLED
}

public plugin_precache() 
{
  precache_sound("misc/ctwinnar2.wav")
  precache_sound("misc/ctwinnar3.wav")
  precache_sound("misc/ctwinnar4.wav")
  precache_sound("misc/twinnar.wav")
  precache_sound("misc/twinnar2.wav")
  precache_sound("misc/twinnar3.wav")

  return PLUGIN_CONTINUE
}

