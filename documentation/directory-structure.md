# Account Directory Structure

Over the years I've tried to fight the default directory structure and implement
my own. It always ends up being more of a headache than it was worth. Now I
embrase the default directory structure and just overlay additional directories
as needed. Below is the general structure I use today. It works well on Linux, but
also fits into the Windows and OSX default directory structures.

> Note: `User` is the name of the directory associated with the user's account.  

```
User
|-- Desktop
|-- Documents
|-- Downloads
|-- Music
|-- Pictures
|-- Projects
|-- Toolbox
|-- Videos
```

**Desktop**
I don't use the Desktop for any kind of file storage or organization. Putting
things here clutters up the GUI view and doesn't really provide any context for
what types of files might be stored here.  

**Documents**
As with the Desktop, I don't use the Documents folder a lot. I will
occassionally put a file here or create sub-directories for a set of files if it
doesn't have a better spot to go.  

**Downloads**
The Downloads directory is used by browsers for file downloads. I just piggy
back on that and use this directory for any files that want to manually import
onto my machine or export somewhere else (i.e. another machine or storage
media). I also try to remove or move files from here into their proper spot
immediately after downloading or importing. 

**Music**
I don't use the Music directory at this point in time.  

**Pictures**
I use the pictures directory to store any screenshots I take via the keyboard
and for any pictures I want to keep on my local machine and not push to a
server.  

**Projects**
This is my most used directory. I organize all my work into different projects
inside of this directory. All files associated with a project live in the
project's directory. Files that are shared across multiple projects are hard
to organize this way, but something that I don't run into often. The few times
I do run into files that need to be in two projects, I handle them in one of two
ways.

My default response is to just duplicate the common files in each project
where they are needed. Many times the common files are either transient (i.e.
temporary files, files pulled down from from a server like NPM, Github,
Google Drive, etc.) or they do not need to keep their contents in sync with each
other. Since I'm only working on 2-3 projects at a time, the storage space lost
by duplicating these types of files costs less than the time it would take to
extract them to a single location and reference them in each project.
 
My secondary response is to take the time to extract the files from the project
to a common location and reference them or create a push script that will push
the common files where they need to go. I really don't like doing this as it
creates a dependency between projects that I have to maintain, so I only do this
if absolutely necessary.

**Toolbox**
This is the directory where I put things that I create (templates, scripts,
config files, project installs, etc.) or tools I download from the internet.

**Videos**
This is where I store screen captures and videos I want to keep on my local
machine and not push to a server.  
