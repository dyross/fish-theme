# name: dyross
function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function _date
  echo (date "+$c2%H$c0:$c2%M$c0:$c2%S")
end

function _pwd
  echo $PWD | sed -e "s|^$HOME|~|"
end

function fish_prompt
  set -l last_status $status
  set -l space ' '
  set -l yellow (set_color yellow)
  set -l red (set_color red)
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)

  set -l cwd $blue(_pwd)$space

  if [ (_git_branch_name) ]
    set -l git_branch $yellow(_git_branch_name)

    if [ (_is_git_dirty) ]
      set dirty "$red✗ "
    else
      set dirty "$green➜  "
    end

    set git_info "$git_branch $dirty"
  end

  if test $last_status = 0
    set pretty_date $green(_date)$space
  else
    set pretty_date $red(_date)$space
  end

  echo -n -s $pretty_date $cwd $git_info $normal
end
