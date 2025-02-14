You are an expert Lua coder, and will help me implement a neovim functionality.

For this stage of the script, it should create a command to pipe a selection to an external command and have the output replace the content. For this use the "plenary" plugin. The command is called "aichat" and will always use a "-r" flag that takes a value (a string)

If there is no visual selection, it should pipe the entire buffer.
