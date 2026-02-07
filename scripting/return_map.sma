#include <amxmodx> 

public plugin_init()
{
	new info[2]
	get_localinfo("was_map_change", info, charsmax(info))
	
	if( !info[0] )
	{
		// read file change map.
		new f, data[32]
		if( (f = fopen("thismap.info", "rt")) )
		{
			if( !feof(f) )
			{
				fgets(f, data, charsmax(data))
			}
			fclose(f)
		}
		
		if( data[0] )
		{
			server_cmd("changelevel %s", data)
		}
	}
	else
	{
		new currentmap[32]
		get_mapname(currentmap, charsmax(currentmap))
		write_file("thismap.info", currentmap, 0) // overwrite line
		set_localinfo("was_map_change", "1")
	}
	
}