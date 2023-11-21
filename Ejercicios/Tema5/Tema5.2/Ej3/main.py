import requests
import random
import functions_framework

@functions_framework.http
def get_random_person_name(request):
    random_number = random.randint(1, 10)
    url = "https://jsonplaceholder.typicode.com/users/" + str(random_number)
    response = requests.get(url)
    
    if response.status_code == 200:
        data = response.json()
        name = data['name']
        return("Random person's name:", name)
    else:
        return("Failed to retrieve data")
