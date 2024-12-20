import numpy as np
import time
import json
import matplotlib.pyplot as plt

def shell_sort(arr, increments):
    n = len(arr)
    for gap in increments:
        for i in range(gap, n):
            temp = arr[i]
            j = i
            while j >= gap and arr[j - gap] > temp:
                arr[j] = arr[j - gap]
                j -= gap
            arr[j] = temp

def generate_random_array(size):
    return np.random.randint(low=1, high=1000000, size=size).tolist()

def measure_time(arr, increments):
    start = time.time()
    shell_sort(arr, increments)
    end = time.time()
    return end - start

def get_increments(n):
    return {
        'O(n^2)': [int(n / 2**k) for k in range(1, 20)],
        'O(n^4/3)': [int(n / (k+1)**(4/3)) for k in range(1, 20)],
        'O(n^3/2)': [int(n / (k+1)**(3/2)) for k in range(1, 20)],
        'Inkrementy o Zmniejszeniu Kwadratowym': [int(n / (k+1)**2) for k in range(1, 10)],
        'Inkrementy o Zwiększonym Zmniejszeniu Ułamkowym': [int(n / (k+1)**1.25) for k in range(1, 15)],
        'Inkrementy o Łagodnym Zmniejszeniu Ułamkowym': [int(n / (k+1)**1.1) for k in range(1, 20)]
    }

sizes = range(10000, 501000, 10000)
times = {key: [] for key in ['O(n^2)', 'O(n^4/3)', 'O(n^3/2)', 'Inkrementy o Zmniejszeniu Kwadratowym', 'Inkrementy o Zwiększonym Zmniejszeniu Ułamkowym', 'Inkrementy o Łagodnym Zmniejszeniu Ułamkowym']}

for size in sizes:
    original_array = generate_random_array(size)
    increments = get_increments(size)
    for inc_name, inc in increments.items():
        arr = original_array.copy()
        t = measure_time(arr, inc)
        times[inc_name].append(t)
        print(f"Size: {size}, Increments: {inc_name}, Time: {t}")

# Save results to a JSON file
with open('shell_sort_times.json', 'w') as file:
    json.dump(times, file, indent=4)

# Load data from JSON file
with open('shell_sort_times.json', 'r') as file:
    times = json.load(file)

# Generate the plot from loaded data
plt.figure(figsize=(10, 8))
for inc, t in times.items():
    plt.plot(sizes, t, label=f'Increments: {inc}')

plt.xlabel('Size of array')
plt.ylabel('Time to sort (seconds)')
plt.title('Shell Sort Time Complexity Analysis')
plt.legend()
plt.grid(True)
plt.show()
