alias blog='cd ~/github/blog'
alias book='cd ~/github/blog/_posts/book'
alias css='cd ~/github/blog/_assets/stylesheets/'
alias dandp='cd ~/github/blog/_posts/dandp'
alias font='cd ~/github/blog/_assets/fonts/'
alias img='cd ~/github/blog/_assets/images/'
alias include='cd ~/github/blog/_includes'
alias js='cd ~/github/blog/_assets/javascripts/'
alias layout='cd ~/github/blog/_layouts'
alias tech='cd ~/github/blog/_posts/tech'
alias vendor='cd ~/github/blog/_assets/vendors/'
alias wblog='cd ~/github/blog/_posts/blog'
alias nb=newblog
alias serve='bundle exec jekyll serve --drafts --watch'

newblog(){
  cp template.md $(date +"%Y-%m-%d")-"$*".md && atom $(date +"%Y-%m-%d")-"$*".md
}
