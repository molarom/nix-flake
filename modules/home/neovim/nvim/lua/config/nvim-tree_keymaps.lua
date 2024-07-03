local on_attach = function(_, bufnr)
  local bind = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  bind('<C-]>',   require('nvim-tree.api').tree.change_root_to_node,        'Nvim-Tree: CD' )
  bind('<C-e>',   require('nvim-tree.api').node.open.replace_tree_buffer,   'Nvim-Tree: Open: In Place' )
  bind('<C-k>',   require('nvim-tree.api').node.show_info_popup,            'Nvim-Tree: Info' )
  bind('<C-r>',   require('nvim-tree.api').fs.rename_sub,                   'Nvim-Tree: Rename: Omit Filename' )
  bind('<C-t>',   require('nvim-tree.api').node.open.tab,                   'Nvim-Tree: Open: New Tab' )
  bind('<C-v>',   require('nvim-tree.api').node.open.vertical,              'Nvim-Tree: Open: Vertical Split' )
  bind('<C-x>',   require('nvim-tree.api').node.open.horizontal,            'Nvim-Tree: Open: Horizontal Split' )
  bind('<BS>',    require('nvim-tree.api').node.navigate.parent_close,      'Nvim-Tree: Close Directory' )
  bind('<CR>',    require('nvim-tree.api').node.open.edit,                  'Nvim-Tree: Open' )
  bind('<Tab>',   require('nvim-tree.api').node.open.preview,               'Nvim-Tree: Open Preview' )
  bind('>',       require('nvim-tree.api').node.navigate.sibling.next,      'Nvim-Tree: Next Sibling' )
  bind('<',       require('nvim-tree.api').node.navigate.sibling.prev,      'Nvim-Tree: Previous Sibling' )
  bind('.',       require('nvim-tree.api').node.run.cmd,                    'Nvim-Tree: Run Command' )
  bind('-',       require('nvim-tree.api').tree.change_root_to_parent,      'Nvim-Tree: Up' )
  bind('a',       require('nvim-tree.api').fs.create,                       'Nvim-Tree: Create File Or Directory' )
  bind('bd',      require('nvim-tree.api').marks.bulk.delete,               'Nvim-Tree: Delete Bookmarked' )
  bind('bt',      require('nvim-tree.api').marks.bulk.trash,                'Nvim-Tree: Trash Bookmarked' )
  bind('bmv',     require('nvim-tree.api').marks.bulk.move,                 'Nvim-Tree: Move Bookmarked' )
  bind('B',       require('nvim-tree.api').tree.toggle_no_buffer_filter,    'Nvim-Tree: Toggle Filter: No Buffer' )
  bind('c',       require('nvim-tree.api').fs.copy.node,                    'Nvim-Tree: Copy' )
  bind('C',       require('nvim-tree.api').tree.toggle_git_clean_filter,    'Nvim-Tree: Toggle Filter: Git Clean' )
  bind('[c',      require('nvim-tree.api').node.navigate.git.prev,          'Nvim-Tree: Prev Git' )
  bind(']c',      require('nvim-tree.api').node.navigate.git.next,          'Nvim-Tree: Next Git' )
  bind('d',       require('nvim-tree.api').fs.remove,                       'Nvim-Tree: Delete' )
  bind('D',       require('nvim-tree.api').fs.trash,                        'Nvim-Tree: Trash' )
  bind('E',       require('nvim-tree.api').tree.expand_all,                 'Nvim-Tree: Expand All' )
  bind('e',       require('nvim-tree.api').fs.rename_basename,              'Nvim-Tree: Rename: Basename' )
  bind(']e',      require('nvim-tree.api').node.navigate.diagnostics.next,  'Nvim-Tree: Next Diagnostic' )
  bind('[e',      require('nvim-tree.api').node.navigate.diagnostics.prev,  'Nvim-Tree: Prev Diagnostic' )
  bind('F',       require('nvim-tree.api').live_filter.clear,               'Nvim-Tree: Live Filter: Clear' )
  bind('f',       require('nvim-tree.api').live_filter.start,               'Nvim-Tree: Live Filter: Start' )
  bind('g?',      require('nvim-tree.api').tree.toggle_help,                'Nvim-Tree: Help' )
  bind('gy',      require('nvim-tree.api').fs.copy.absolute_path,           'Nvim-Tree: Copy Absolute Path' )
  bind('ge',      require('nvim-tree.api').fs.copy.basename,                'Nvim-Tree: Copy Basename' )
  bind('H',       require('nvim-tree.api').tree.toggle_hidden_filter,       'Nvim-Tree: Toggle Filter: Dotfiles' )
  bind('I',       require('nvim-tree.api').tree.toggle_gitignore_filter,    'Nvim-Tree: Toggle Filter: Git Ignore' )
  bind('J',       require('nvim-tree.api').node.navigate.sibling.last,      'Nvim-Tree: Last Sibling' )
  bind('K',       require('nvim-tree.api').node.navigate.sibling.first,     'Nvim-Tree: First Sibling' )
  bind('L',       require('nvim-tree.api').node.open.toggle_group_empty,    'Nvim-Tree: Toggle Group Empty' )
  bind('M',       require('nvim-tree.api').tree.toggle_no_bookmark_filter,  'Nvim-Tree: Toggle Filter: No Bookmark' )
  bind('m',       require('nvim-tree.api').marks.toggle,                    'Nvim-Tree: Toggle Bookmark' )
  bind('o',       require('nvim-tree.api').node.open.edit,                  'Nvim-Tree: Open' )
  bind('O',       require('nvim-tree.api').node.open.no_window_picker,      'Nvim-Tree: Open: No Window Picker' )
  bind('p',       require('nvim-tree.api').fs.paste,                        'Nvim-Tree: Paste' )
  bind('P',       require('nvim-tree.api').node.navigate.parent,            'Nvim-Tree: Parent Directory' )
  bind('q',       require('nvim-tree.api').tree.close,                      'Nvim-Tree: Close' )
  bind('r',       require('nvim-tree.api').fs.rename,                       'Nvim-Tree: Rename' )
  bind('R',       require('nvim-tree.api').tree.reload,                     'Nvim-Tree: Refresh' )
  bind('s',       require('nvim-tree.api').node.run.system,                 'Nvim-Tree: Run System' )
  bind('S',       require('nvim-tree.api').tree.search_node,                'Nvim-Tree: Search' )
  bind('u',       require('nvim-tree.api').fs.rename_full,                  'Nvim-Tree: Rename: Full Path' )
  bind('U',       require('nvim-tree.api').tree.toggle_custom_filter,       'Nvim-Tree: Toggle Filter: Hidden' )
  bind('W',       require('nvim-tree.api').tree.collapse_all,               'Nvim-Tree: Collapse' )
  bind('x',       require('nvim-tree.api').fs.cut,                          'Nvim-Tree: Cut' )
  bind('y',       require('nvim-tree.api').fs.copy.filename,                'Nvim-Tree: Copy Name' )
  bind('Y',       require('nvim-tree.api').fs.copy.relative_path,           'Nvim-Tree: Copy Relative Path' )
end

return on_attach
