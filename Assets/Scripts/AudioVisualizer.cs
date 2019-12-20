using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioVisualizer : MonoBehaviour {

	public AudioSource music;
	public float multiplier;
	public float circleRadius;
	public float[] samples = new float[512];
	public GameObject cubePrefab;
	public GameObject[] cubes = new GameObject[256];

	// Use this for initialization
	public void found () {
		for (int i = 0; i < cubes.Length; i++)
		{
			cubes[i] = Instantiate(cubePrefab, transform.position, Quaternion.identity);
			cubes[i].transform.parent = transform;
			transform.eulerAngles = new Vector3(0,-1.40625f * i, 0);
			cubes[i].transform.localPosition = transform.forward * circleRadius;
		}
	}

	public void lost(){
		cubes = new GameObject[256];
	}
	
	// Update is called once per frame
	void Update () {
		getSamples();
	}

	void getSamples(){
		music.GetSpectrumData(samples, 0, FFTWindow.Blackman);
		for (int i = 0; i < cubes.Length; i++)
		{
			cubes[i].transform.localScale  = new Vector3(.02f, .02f,Mathf.Max(0.1f, (float) (samples[i] * multiplier)));
		}
	}
}
