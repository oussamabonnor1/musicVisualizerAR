using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioVisualizer : MonoBehaviour {

	public AudioSource music;
	public float multiplier;
	public float circleRadius;
	public float minCubeHeight;
	public GameObject cubePrefab;
	public float[] samples = new float[512];
	public GameObject[] cubes;

	public void Start(){
	}

	// Use this for initialization
	public void found () {
			for (int i = 0; i < cubes.Length; i++) {
				if(!ImageTargetController.alreadyFound) cubes[i] = Instantiate (cubePrefab, transform.position, Quaternion.identity);
				cubes[i].transform.parent = transform;
				transform.localEulerAngles = new Vector3 (0, -((float) (360f / cubes.Length)) * i, 0);
				cubes[i].transform.localPosition = transform.forward * circleRadius;
				cubes[i].transform.LookAt (transform.up);
			}
	}

	// Update is called once per frame
	void Update () {
		if(gameObject.activeSelf && ImageTargetController.found) getSamples ();
	}

	void getSamples () {
		music.GetSpectrumData (samples, 0, FFTWindow.Blackman);
		for (int i = 0; i < cubes.Length; i++) {
			cubes[i].transform.localScale = new Vector3 (.02f, .02f, Mathf.Max (minCubeHeight, (float) (samples[i] * multiplier)));
		}
	}
}