local logo = [[
         .                  *.                                                                               
       .*%0.                &&*.                                                                             
     .*%%%00*               &&&&*.                                                     .*.                   
   .*%%%%%000*              &&&&&&*.                          ..*******.              .%@&'                  
 .*%%%%%%%00000             &&&&&&&&*.                 .*0&%%@@@@@@@@@@@&0^          *@@@&'                  
*00%%%%%%%000000.           &&&&&&&&&&*            o&@@@@%&00*^^^''''^^*0%&'       *@@@&                     
0000%%%%%%0000000*          &&&&&&&&&&&          '%@@%0^ .*.              &%000&&&&@@@@&&&0o                 
000000%%%%000000000.        &&&&&&&&&&&           0@*   0%@@0            *@@&&000%@@@0^^'                    
0000000%%%0000000000*       &&&&&&&&&&&                00*@@0          *&@%'    0@@@0                  *.    
00000000%%000000000000      &&&&&&&&&&&               0 *@@%        .0%@@0'    0@@@0     *%&          &@%'   
000000000%'000000000000.    &&&&&&&&&&&              ^ 0@@%'     .o&@@&^      0@@@0     *@@&  .*.    &@@0    
0000000000 '000000000000.   &&&&&&&&&&&             .*&@@%'  .*0%@@&*'       *@@@0     *@@%  .0@%   0@@*     
0000000000   '00000000000*  &&&&&&&&&&&            *0%@@@%%%@@@%0^          *@@@0     *@@%  *%@@%  *@@^      
0000000000    '000000000000.&&&&&&&&&&&           @@@@@@@@@@@%0'           '@@@&     *@@%  &0%@@* *@%'       
0000000000      000000000000%&&&&&&&&&&           0@@@^    '^00%@&o.       %@@%'    *@@@'.&^0@@% *@%'        
0000000000       ^0000000000%%&&&&&&&&&          '@@%'          '0@@&'    &@@@'   .&@@@ 0&''@@@*o@&          
0000000000        '000000000%%%%&&&&&&&         '@@%'            0@@@0   *@@@^  .00@@@0&0  %@@%0@0           
0000000000          00000000%%%%%%&&&&&        '@@&           .0@@@@0   '@@@* .*0'&@@@%*  *@@@%@0            
0000000000           '000000%%%%%%%%&&*        %@0        .*&%@@%&^     0@@&'0&^ ^@@@@^   &@@@@*             
 ^00000000            '00000%%%%%%'.*.         *0'  .*00&%@@@&0*'       ^0@@%&^    0@@&    &@@%^             
   ^000000              ^000%%%%% &@&0o.o0000&&%%@@@@%&0*^'              ^0^        ''     ''                
     ^0000               '00%%%%% ^&&%%%%&&&&000*^^'                                                         
       ^00                '0%%%%'                                                                            
         '                  ^''                                                                              
]]

logo = string.rep("\n", 8) .. logo .. "\n\n"

return {
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			picker = {
				sources = {
					explorer = {
						hidden = true,
						-- ignored = true,
						layout = { preset = "default", focus = "list" }, -- "default" preset in Snacks pickers is a centered floating window
						jump = { close = true }, -- This ensures it behaves like a standard picker (closes on select)
					},
					files = {
						hidden = true,
						ignored = false,
					},
				},
			},
			explorer = {
				-- enabled = false,
				-- replace_netrw = false, -- This stops it from hijacking the directory view on startup
			},
			dashboard = {
				width = 90,
				preset = {
					header = logo,
				},
				sections = {
					{ section = "header" },
					function()
						local in_git = Snacks.git.get_root() ~= nil
						-- Terminal sections default to height=10; that reserves 10 rows even when git output is short,
						-- which reads as a huge gap before the next section. Tune heights to match typical output.
						local cmds = {
							{
								icon = " ",
								title = "Git Status",
								cmd = "git status -uall --short --branch",
								height = 6,
							},
							{
								icon = " ",
								title = "Git log",
								cmd = 'git log --pretty=format:"%C(yellow)%h%Creset %C(green)%an%Creset %C(blue)(%cr)%Creset %s" --date=format:"%a %d-%m-%Y %H:%M" -n 5',
								height = 6,
							},
						}
						return vim.tbl_map(function(cmd)
							return vim.tbl_extend("force", {
								section = "terminal",
								enabled = in_git,
								ttl = 5 * 60,
								-- indent = 3,
								clear = true, -- Prevents [Process exited 0] being displayed beneath command output
							}, cmd)
						end, cmds)
					end,
					{ section = "startup", padding = { 0, 2 } },
					function()
						local ver = vim.version()
						local nvim_ver = string.format("v%d.%d.%d", ver.major, ver.minor, ver.patch)
						local ok, cfg = pcall(require, "lazyvim.config")
						local lv_ver = (ok and cfg and cfg.version) or "—"
						return {
							align = "center",
							padding = { 1, 1 },
							text = {
								{ nvim_ver .. "  ·  ", hl = "footer" },
								{ "LazyVim " .. lv_ver, hl = "special" },
							},
						}
					end,
				},
			},
		},
	},
}
