# README
Instagram Clone

A clone of Facebook's Instagram app where you can login/register, create new posts, follow other users and see other people you follows posts

You should create a MVP (Minimum Viable Product) using a Full stack approach to store images and display them to the client.

User Stories:
- User can register for an account storing their real name, email ,nickname and password then login to the app using their credentials
- User can create a post and store images to the server
- User has a profile that displays all the images they have uploaded
- User can like posts
- User can follow other users
- Posts from followed users are shown before other posts unless the are 1 day old
- User can see other users posts
- The feed auth refreshes when a new post is added (You can use Web Sockets)
- User can add description to uploaded images
- User can search posts by description and users by nickname
- Feed supports pagination

Stack:
- ruby 2.6.3
- rails 6
- mysql
- bootstrap

May be useful https://www.ruby-toolbox.com/

Трохи розясню сторьки

в загальному все просто
юзер може регається на сайті
постити картінки із коментами
є головна сторінка на якій показуються пости інших юзерів які можна лайкати
в першу чергу показуються пости юзерів яких ти фоловаєш якщо вони не дуже старі
також на сторінці має бути пошук щоб фільтрував по опису постів і нікнеймах юзерів
фільтрація апдейтить стрічу аяксом
в пості має показуватись хто його запостив, опис і лайк кнопочка
із поста можна перейти на сторінку юзера який його запостив
урла профайлу юзера має бути не /users/1 а /users/[:nickname]
в профайлі має показуватись картинки юзера, картинки які він лайкнув, юзери яких він фоловає

___________

по позиціонуванню, що де розташоване і тд - це вирішуєш ти
єдиний реквайрмент щоб воно було акуратно, не оверлапилось нічого
достатньо юзати бутстрап останній без жодних тем
фреймворки фронтові непотрібні
проект має бути на гітхабі
для логіну/реєстрації юзай devise gem
якщо в тебе буде виникати вибір написати щось самому чи заюзати якийсь гем краще юзай гем для економії часу
можеш в любий момент мене пінгати із питаннями і по реквайрментах і технічних