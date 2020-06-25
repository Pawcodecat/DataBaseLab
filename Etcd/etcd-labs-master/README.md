# Wprowadzenie do laboratorium z Etcd

Laboratorium z bazy danych Etcd będzie przeprowadzopne w środowiska Jupyter Notebooks w Watson Studio,
które wymaga rejestracji w IBM Cloud.
Dla studentów i pracowników naukowych oferujemy specjalne kody promocyjne, które pozwalają na pracę z większą ilością
serwisów w chmurze.

Procedura rejestracji:
https://ibm.box.com/shared/static/nw3ednr2c43gzaw4gj1yl1ak0jgv1qkg.pptx

Konto IBM Cloud umożliwia dostęp do Watson Studio, po zalogowaniu się pod adresem: 
https://dataplatform.cloud.ibm.com/home

## Tworzenie projektu w Watson Studio

Sciągnij z repozytorium git plik o nazwie: [Etcd-Labs.zip](./Etcd-Labs.zip) i zapisz na dysku lokalnym.

Na stronie głównej [Watson Studio](https://dataplatform.cloud.ibm.com/home) kliknij 'New project':

![Watson Studio - Main Screen](./images/01-main-screen.png)

Następnie wybierz 'Create a project from a sample or file':

![Create project from file](./images/02-create-project-from-file.png)

Aby móc stworzyć projekt potrzebujesz miejsce na twoje zasoby, kliknij 'Add' w sekcji '1. Select storage service':

![Select storage service](./images/03-add-cos.png)

Na kolejnym ekranie wybierz darmowy plan 'Lite':
 
![Select Lite plan](./images/04-select-lite-cos-plan.png)

i potwierdź wybór:

![Confirm Lite plan](./images/05-confirm-lite-plan.png)

Po powrocie na ekran tworzenia projektu, wybierz ściągnięty plik: 'Etcd-Labs.zip'

![Select project archive](./images/06-select-project-archive.png)

nazwij projekt i wciśnij 'Create':

![Name the project](./images/07-project-name.png)

Przejdź do stworzonego projektu wybierając 'View new project':

![View new project](./images/08-view-new-project.png)

W zakładce 'Assets' wybierz _notebook_ 'etcd_lab':

![Open notebook](./images/09-open-notebook.png)

Gratulacje! Możesz przystąpić do realizacji zadań.