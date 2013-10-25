" Goals are to being able to import multi-module projects using eclim

" - run mvn eclipse:clean eclipse:eclipse
" - delete .project and .classpath on root if exists ( this will be generated later )
" - find all instances of .project and for each import as a project on eclipse with a prefix of the root project folder name example 'myfoldername_inner-module'
" - create a new project with all the previously created projects as its dependencie
" - wrappeverything in a function ":ProjectImportMultiModule"


""
" Get a list of all eclipse projects that are in the same folder by checking
" for the existend of '.project' and than returning the path to the the containing directory.
"
" @return {String} Return folders that has a '.project' on them.
"
function! GetEclimProjectList()
    return substitute(globpath('.', '**/.project'), '\/.project', '','g')
endfunction


""
" Get the name of the directory
"
" @return {String} Return folders that has a '.project' on them.
"
function! GetProjectName(projectPath)
    let l:projectName = substitute(a:projectPath, '.*\/', '','g')

    return projectName
endfunction

" Rename project with a prefix and return new name
function! AddPrefixToProject(projectName, prefix)
    l:separator = '_'
    l:newProjectName = a:prefix . separator . a:projectName

    echo "ProjectRename " . a:project " " . newProjectName

    execute "ProjectRename " . a:project " " . newProjectName

    return  newProjectName
endfunction

" Import all projects from '.' or specified by the argument
function! ProjectRemoveRecursive(project)

    " import project with eclim
    let l:project = a:project

    " get the project name to later on add on createProject
    let l:projectName = GetProjectName(project)

    echo "ProjectDelete " . project

    try
        "execute "ProjectDelete " . project
    catch
        " project already imported
        echo "Failed to remove project, maybe it doesn't exists or already have been deleted."
    endtry

    return projectName . " "
endfunction

" Import all projects from '.' or specified by the argument
function! ProjectImportRecursive(project)

    " import project with eclim
    let l:project = a:project

    " get the project name to later on add on createProject
    let l:projectName = GetProjectName(project)

    echo "ProjectImport " . project

    try
        "execute "ProjectImport " . project
    catch
        " project already imported
        echo "Failed to import project, maybe its already imported"
    endtry

    return projectName . " "
endfunction

" exec a function on each line of the output
function! DoForEachLine(list, func)
  let responseList = ""

  let item = split(a:list, "\n")

  for line in item
    let responseList = responseList . a:func(line)
  endfor

  return responseList
endfunction

function! CreateProjectWithDependencyList(folder, projectName, list)
    try
        echo "Running command: ProjectCreate " . a:folder . " -p " . a:projectName . " -n java" .  " -d " . a:list
        "execute "ProjectCreate " . a:folder . " -p " . a:projectName . " -n java" .  " -d " . a:list
        echo "Project succesfuly created as: " . a:projectName
    catch
        echo "Failed to create project"
    endtry
endfunction


nnoremap <F12> :call ProjectCreateMvnMultiModule()<CR>
command! -nargs=1 ProjectCreateMvnMultiModule call s:ProjectCreateMvnMultiModule(<f-args>)

function! ProjectCreateMvnMultiModule()
  let responseList = DoForEachLine(GetEclimProjectList(), function("ProjectImportRecursive"))
  let projectDependencies = substitute(responseList, "\n", ' ', 'g')

  call CreateProjectWithDependencyList(".", "miter", projectDependencies)
endfunction
