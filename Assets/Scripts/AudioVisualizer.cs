using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioVisualizer : MonoBehaviour {

	public AudioSource music;
	public float multiplier;
	public float circleRadius;
	public float minCubeHeight, cubeDimensions;
	public GameObject cubePrefab;
	public float[] samples = new float[512];
	public GameObject[] cubes;

	public void Start () { }

	// Use this for initialization
	public void found () {
		
	}

	// Update is called once per frame
	void Update () {
		if (gameObject.activeSelf && ImageTargetController.found) getSamples ();
	}

	void getSamples () {
		music.GetSpectrumData (samples, 0, FFTWindow.Blackman);
		for (int i = 0; i < cubes.Length; i++) {
			cubes[i].transform.localScale = new Vector3 (cubeDimensions, cubeDimensions, Mathf.Max (minCubeHeight, (float) (samples[i] * multiplier)));
		}
	}
}