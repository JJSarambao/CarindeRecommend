import os
import cv2
import numpy as np
import tensorflow as tf
from tensorflow.lite.python.interpreter import Interpreter

# print(os.path.exists("scripts/model/yolov8-coco.tflite"))
model_path = "scripts/model/yolov8-coco.tflite"

# Load the TensorFlow Lite model.
interpreter = Interpreter(model_path=model_path)
interpreter.allocate_tensors()

# Get input and output tensors.
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

# Get the input shape of the model.
input_shape = input_details[0]['shape']

# Extract the labels from the model metadata.
model_metadata = interpreter.get_metadata()
label_map = model_metadata.get('vocabulary')
if label_map is not None:
    labels = label_map.get('label')
else:
    labels = None

# Define the colors for the bounding boxes.
colors = np.random.uniform(0, 255, size=(len(labels), 3))

# Define a function to perform object detection.
def detect_objects(frame):
    # Preprocess the input image.
    resized_frame = cv2.resize(frame, (input_shape[2], input_shape[1]))
    input_data = np.expand_dims(resized_frame, axis=0)
    input_data = (np.float32(input_data) - 127.5) / 127.5

    # Run inference on the input data.
    interpreter.set_tensor(input_details[0]['index'], input_data)
    interpreter.invoke()
    output_data = interpreter.get_tensor(output_details[0]['index'])

    # Process the output data.
    for i, det in enumerate(output_data[0]):
        # Extract the class ID and confidence score from the output data.
        class_id = int(det[1])
        confidence = det[2]

        # If the confidence score is above a certain threshold, draw a bounding box around the object.
        if confidence > 0.5:
            # Get the coordinates of the bounding box.
            xmin = int(det[3] * frame.shape[1])
            ymin = int(det[4] * frame.shape[0])
            xmax = int(det[5] * frame.shape[1])
            ymax = int(det[6] * frame.shape[0])

            # Draw the bounding box and label.
            if labels is not None:
                label = labels[class_id]
            else:
                label = str(class_id)
            cv2.rectangle(frame, (xmin, ymin), (xmax, ymax), colors[class_id], 2)
            cv2.putText(frame, label + " " + str(round(confidence, 2)), (xmin, ymin - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, colors[class_id], 2)

    return frame

# Define the video capture device.
cap = cv2.VideoCapture(1)

# Start the video capture loop.
while True:
    # Capture a frame from the video capture device.
    ret, frame = cap.read()

    # Perform object detection on the frame.
    frame = detect_objects(frame)

    # Display the resulting frame.
    cv2.imshow('Object Detection', frame)

    # Exit the loop if the 'q' key is pressed.
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the video capture device and close the window.
cap.release()
cv2.destroyAllWindows()
