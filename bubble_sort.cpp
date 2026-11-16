// Type your code here, or load an example.
void bubbleSort(int arr[]) {
    int len = sizeof(arr);
    for (int i = (len -1); i > 0; i--){
        bool swapped = false;
        for (int j = 0; j < i; j++){
            if (arr[j] > arr[j+1]){
                int temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
                swapped = true;
            }
        }
        if (swapped == false) return;
    }
}