# stat999-myst

 
The course website is here https://stat151a.stat.berkeley.edu/spring-2024/
The git repo is here https://github.com/berkeley-stat151a/spring-2024


Common commands
- `myst init`
- `myst build`
- `myst start`
- `conda info --envs`
- `conda env create -f environment.yml`
- `conda activate stat-myst-site`


Beamer:



Checkout the `slides` branch of the repo which contains two new Lecture md files with requisite frontmatter. (yaml config in the header)
Create a `templates` directory at the same level as your spring-2024 working directory. (although I think you named yours stat151a-spring-2024)
Change into that directory and run `git clone --recursive https://github.com/kai-tub/latex_beamer_pure_minimalistic_mystjs`. The `--recursive` flag also clones a submodule contained within the repo.
(suggested) copy `stat_bear.png` from the course dir to templates/latex_beamer_pure_minimalistic_mystjs/logos/header_logo.png, overwriting it. (we might need to fork that repo just to be able to do this)
Change back into the spring-2024 directory and run `myst build Lectures/Lecture1.md --pdf`.


myst build Lectures/Lecture1.md --pdf

Note you need to install latexmk
xelatex missing? sudo apt-get install texlive-xetex

Also ran
npm install -g jtex

pdftk big_file.pdf cat 3 output page3.pdf


To run R in Jupyter you need 
https://github.com/IRkernel/IRkernel
In R:
> install.packages('IRkernel')
> IRkernel::installspec()  # to register the kernel in the current R installation