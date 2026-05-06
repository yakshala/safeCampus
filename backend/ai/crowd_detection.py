person_count = 0

for box in boxes:
    cls = int(box.cls[0])

    if cls == 0:
        person_count += 1

if person_count > 30:
    print("Overcrowding detected")