" Config para o Startify

let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_lists = [
	\ { 'type': 'bookmarks', 'header': ['	Bookmarks']	},
	\ { 'type': 'files',	 'header': ['	Recentes']	},
	\ { 'type': 'sessions',	 'header': ['	Sessions']	},
	\ ]
let g:webdevicons_enable_startify =1
let g:startify_bookmarks = [
	\ { 'v': '~/dotfiles/nvim/init.vim' },
	\ { 'z': '~/dotfiles/.zshrc' },
	\ ]
let g:startify_files_number = 5
let g:startify_fortune_use_unicode = 1
let g:startify_padding_left = 5
