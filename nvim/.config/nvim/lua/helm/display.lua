
vim.cmd[[
" Change theme based on time of day
" Winter sunset at 5pm Summer sunset at 8pm
let g:sunrise = 7
let g:sunset = 18

let g:dusk_til_dawn_light_theme = 'doom-one'
let g:dusk_til_dawn_dark_theme = 'doom-one'
let g:dusk_til_dawn_dawn = sunrise
let g:dusk_til_dawn_night = sunset

lua require"Dusk-til-Dawn".timeMan()()
]]
